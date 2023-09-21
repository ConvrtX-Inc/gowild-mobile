package com.android.gowild.ui.map.treasurewild

import android.app.Activity
import android.app.AlertDialog
import android.app.DatePickerDialog
import android.graphics.Color
import android.graphics.PorterDuff
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.TextView
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.settings.EditProfileRequestUpdateModel
import com.android.gowild.databinding.FragmentRegistrationBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.fieldwatcher.TextFieldValidation
import com.bumptech.glide.Glide
import com.github.drjacky.imagepicker.ImagePicker
import com.github.drjacky.imagepicker.constant.ImageProvider
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import timber.log.Timber
import java.io.File
import java.io.FileOutputStream
import java.util.Calendar

class RegisterTreasureHuntFragment : BaseFragment() {
    companion object {
        @JvmStatic
        fun newInstance(huntId: String, huntPic: String, huntName: String) =
            RegisterTreasureHuntFragment().apply {
                arguments = Bundle().apply {
                    putString("huntId", huntId)
                    putString("huntPic", huntPic)
                    putString("huntName", huntName)
                }
            }
    }

    private lateinit var binding: FragmentRegistrationBinding
    private lateinit var datePickerDialog: DatePickerDialog
    val registerTreasureHuntVM: RegisterHuntVM by viewModels()
    lateinit var huntId: String
    lateinit var huntPic: String
    lateinit var huntName: String
    lateinit var frontImageUri: Uri
    lateinit var backImageUri: Uri
    private var frontFile: File? = null
    private var backFile: File? = null

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentRegistrationBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            huntId = it.getString("huntId").toString()
            huntPic = it.getString("huntPic").toString()
            huntName = it.getString("huntName").toString()
        }

        listeners()
        setupObservers()

        val item = arrayOf("Male", "Female", "Other")
        val adapter = activity?.let { ArrayAdapter(it, android.R.layout.simple_spinner_dropdown_item, item) }
        binding.spinner.adapter = adapter

        binding.spinner.prompt = "Select Gender"
        binding.spinner.setSelection(0)
        binding.spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(p0: AdapterView<*>?, view: View?, position: Int, id: Long) {
//                binding.textView.text = item[position]
                (p0?.getChildAt(0) as TextView).setTextColor(
                    Color.WHITE
                )
                (p0?.getChildAt(0) as TextView).textSize =
                    12f
            }

            override fun onNothingSelected(p0: AdapterView<*>?) {

            }
        }

        binding.ccp.registerCarrierNumberEditText(binding.etPhoneNumber)

        val calendar = Calendar.getInstance()
        datePickerDialog = DatePickerDialog(
            requireActivity(), AlertDialog.THEME_HOLO_LIGHT,
            { datePicker, year, month, day ->
                binding.dateOfBirth.text = String.format("%d-%d-%d", month + 1, day, year)
            }, calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH)
        )

        binding.tvUsername.text = huntName
        binding.etFullName.setText(userPrefs.getUser()?.firstName + " " + userPrefs.getUser()?.lastName)
        binding.etEmail.setText(userPrefs.getUser()?.email)
        if (userPrefs.getUser()!!.phoneNo != null && userPrefs.getUser()!!.phoneNo != "") {
            binding.etPhoneNumber.setText(userPrefs.getUser()!!.phoneNo?.substring(3))
            binding.etPhoneNumber.isEnabled = false
        } else {
            binding.etPhoneNumber.isEnabled = true
        }


        Glide
            .with(this)
            .load("https://api.gowild.appscorridor.com$huntPic")
            .placeholder(R.drawable.user_placeholder)
            .error(R.drawable.user_placeholder)
            .into(binding.ivProfile)


    }

    private fun listeners() {
        binding.etFullName.addTextChangedListener(TextFieldValidation(binding.etFullName))
        binding.etEmail.addTextChangedListener(TextFieldValidation(binding.etEmail))
        binding.ccp.setPhoneNumberValidityChangeListener {
            if (it) {
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.white))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.success_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            } else {
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.error_color))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.error_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            }
        }

        binding.dateOfBirth.setOnClickListener {
            datePickerDialog.show()
        }

        binding.registerBtn.setOnClickListener {
            if (isValidInput()) {
                var firstName: String? = null
                var lastName: String? = null
                binding.etFullName.text?.let {
                    val tempArray = it.split(" ")
                    firstName = tempArray.firstOrNull().toString()
                    lastName = tempArray.takeLast(tempArray.size - 1).joinToString(separator = " ")
                }

                Timber.tag("HUNT_ISSUE").wtf("called updateUserProfile")
                registerTreasureHuntVM.updateUserProfile(
                    EditProfileRequestUpdateModel(
                        userPrefs.getUser()?.about_me,
                        userPrefs.getUser()?.addressOne,
                        userPrefs.getUser()?.addressTwo,
                        binding.dateOfBirth.text.toString(),
                        firstName,
                        binding.spinner.selectedItem.toString(),
                        lastName,
                        binding.ccp.fullNumberWithPlus,
                        userPrefs.getUser()?.username
                    )
                )
            }
        }

        binding.viewFront.setOnClickListener {
            ImagePicker
                .with(requireActivity())
                .crop()
                .maxResultSize(1000, 1000)
                .provider(ImageProvider.BOTH)
                .createIntentFromDialog { intent ->
                    frontImageLauncher.launch(intent)
                }
        }

        binding.viewBack.setOnClickListener {
            ImagePicker
                .with(requireActivity())
                .crop()
                .maxResultSize(1000, 1000)
                .provider(ImageProvider.BOTH)
                .createIntentFromDialog { intent ->
                    backImageLauncher.launch(intent)
                }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setupObservers() {
        observeUpdateProfileResponse()
        observeUpdateImageResponse()
        observeUpdateBackImageResponse()
        observeRegisterTreasureHuntResponse()
    }

    private fun observeRegisterTreasureHuntResponse() {
        registerTreasureHuntVM.registerHuntResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    Timber.tag("HUNT_ISSUE").wtf("response registerTreasureHunt")
                    if (response.data?.data != null) {
                        (requireActivity() as MapActivity).popUpToTreasureWild()
                    } else {
                        binding.root.showBar("Already registered")
                    }
                }

                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                    showProgress()
                }

                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }

                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }

                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }

                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }

                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun observeUpdateBackImageResponse() {
        registerTreasureHuntVM.updateUserProfileResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    Timber.tag("HUNT_ISSUE").wtf("response updateUserProfile")
                    Timber.tag("HUNT_ISSUE").wtf("called updateUserImage front")
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    registerTreasureHuntVM.updateUserImageFront(
                        MultipartBody.Part.createFormData(
                            "frontImage",
                            frontFile!!.name,
                            frontFile!!.asRequestBody("image/*".toMediaType())
                        )
                    )
                    hideProgress()
                }

                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                    showProgress()
                }

                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }

                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }

                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }

                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }

                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun observeUpdateImageResponse() {
        registerTreasureHuntVM.updateUserImageFrontResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    Timber.tag("HUNT_ISSUE").wtf("response updateUserImage front")
                    Timber.tag("HUNT_ISSUE").wtf("called updateUserImage back")
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    registerTreasureHuntVM.updateUserImageBack(
                        MultipartBody.Part.createFormData(
                            "backImage",
                            backFile!!.name,
                            backFile!!.asRequestBody("image/*".toMediaType())
                        )
                    )
                    hideProgress()
                }

                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                    showProgress()
                }

                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }

                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }

                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }

                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }

                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun observeUpdateProfileResponse() {
        registerTreasureHuntVM.updateUserImageBackResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    Timber.tag("HUNT_ISSUE").wtf("response updateUserImage back")
                    Timber.tag("HUNT_ISSUE").wtf("called registerTreasureHunt")
                    Timber.tag("HUNT_ISSUE").wtf("--------")
                    hideProgress()
                    registerTreasureHuntVM.registerTreasureHunt(huntId)
                }

                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                    showProgress()
                }

                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }

                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }

                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }

                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }

                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun isValidInput(): Boolean {
        if (!binding.ccp.isValidFullNumber) {
            toast("Invalid phone, please check your phone or country code")
            return false
        }
        if (binding.dateOfBirth.text.isEmpty()) {
            toast("Please select date of birth")
            return false
        }
        if (frontFile == null) {
            toast("Please select front image")
            return false
        }
        if (backFile == null) {
            toast("Please select back image")
            return false
        }
        return true
    }

    private val frontImageLauncher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK) {
                frontImageUri = it.data?.data!!
                binding.frontIdImg.setImageURI(frontImageUri)

                createImageFrontFile(frontImageUri)
            }

        }

    private val backImageLauncher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK) {
                backImageUri = it.data?.data!!
                binding.backIdImg.setImageURI(backImageUri)

                createImageBackFile(backImageUri)
            }
        }

    private fun createImageFrontFile(imageUri: Uri) {
        val fileDir = requireActivity().applicationContext.filesDir
        frontFile = File(fileDir, "front.png")

        val inputStream = requireActivity().contentResolver.openInputStream(imageUri)
        val outputStream = FileOutputStream(frontFile)
        inputStream!!.copyTo(outputStream)
    }


    private fun createImageBackFile(imageUri: Uri) {
        val fileDir = requireActivity().applicationContext.filesDir
        backFile = File(fileDir, "back.png")

        val inputStream = requireActivity().contentResolver.openInputStream(imageUri)
        val outputStream = FileOutputStream(backFile)
        inputStream!!.copyTo(outputStream)
    }
}