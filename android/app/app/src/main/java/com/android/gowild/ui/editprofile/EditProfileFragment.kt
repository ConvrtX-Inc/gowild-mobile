package com.android.gowild.ui.editprofile

import android.app.Activity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.data.model.settings.EditProfileRequestUpdateModel
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.FragmentEditProfileBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.isProfileDataUpdated
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs
import com.github.drjacky.imagepicker.ImagePicker
import com.github.drjacky.imagepicker.constant.ImageProvider
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import timber.log.Timber
import java.io.File

class EditProfileFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = EditProfileFragment()
    }

    lateinit var binding: FragmentEditProfileBinding
    private val editProfileVM: EditProfileVM by viewModels()

    private var file: File? = null
    lateinit var user: User


    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentEditProfileBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupObservers()
        setListeners()
        setUserData()

    }

    private fun setUserData() {
        user = UserPrefs(requireContext()).getUser()!!
        binding.etFirstName.setText(user.firstName)
        binding.etLastName.setText(user.lastName)
        binding.etEmail.setText(user.email)
        binding.etUsername.setText(user.username)
        binding.etAboutMe.setText(user.about_me)
        binding.ivProfile.loadUserImage(user)
        isProfileDataUpdated = false
        Timber.tag("IMAGE_ISSUE").wtf("EditProfileCreated ${user.updatedDate}")
    }

    private fun setListeners() {
        binding.btnSave.setOnClickListener {
            if (validateFields() && isUserDataUpdated()) {
                editProfileVM.updateUserProfile(
                    EditProfileRequestUpdateModel(
                        binding.etAboutMe.text.toString(),
                        user.addressOne,
                        user.addressTwo,
                        user.birthDate,
                        binding.etFirstName.text.toString(),
                        user.gender,
                        binding.etLastName.text.toString(),
                        user.phoneNo,
                        binding.etUsername.text.toString()
                    )
                )
            }

            if (file != null)
                editProfileVM.updateUserImage(
                    MultipartBody.Part.createFormData(
                        "picture",
                        file!!.name,
                        file!!.asRequestBody("image/*".toMediaType())
                    )
                )
        }

        binding.ivProfile.setOnClickListener {
            ImagePicker.with(requireActivity()).cropSquare().maxResultSize(1000, 1000)
                .provider(ImageProvider.BOTH).createIntentFromDialog { intent ->
                    imagePickerLauncher.launch(intent)
                }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun validateFields(): Boolean {
        var isValid = true
        if (binding.etFirstName.text.toString().length !in 2..15) {
            binding.etFirstName.error = "First name characters between 2 to 15"
            isValid = false
        }
        if (binding.etLastName.text.toString().length !in 2..15) {
            binding.etLastName.error = "Last name characters between 2 to 15"
            isValid = false
        }
        return isValid
    }

    private fun isUserDataUpdated(): Boolean {
        if (binding.etFirstName.text.toString().equals(user.firstName.toString()) &&
            binding.etLastName.text.toString().equals(user.lastName.toString()) &&
            binding.etUsername.text.toString().equals(user.username.toString()) &&
            binding.etEmail.text.toString().equals(user.email.toString()) &&
            binding.etAboutMe.text.toString().equals(user.about_me.toString())

        ) {
            if (file == null) {
                toast("Nothing to update")
            }
            return false
        }
        return true
    }

    private fun setupObservers() {
        observeUpdateProfileResponse()
        observeUpdateImageResponse()
    }

    private fun observeUpdateImageResponse() {
        editProfileVM.updateUserImageResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    UserPrefs(requireContext()).updateUserWithoutAccessToken(response.data!!.user)
                    Toast.makeText(requireContext(), "Profile updated successfully", Toast.LENGTH_SHORT).show()
                    Timber.tag("IMAGE_ISSUE").wtf("ImageUpdated ${response.data.user.updatedDate}")
                    file = null
                    isProfileDataUpdated = true
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
        editProfileVM.updateUserProfileResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    UserPrefs(requireContext()).updateUserWithoutAccessToken(response.data!!.user)
                    user = UserPrefs(requireContext()).getUser()!!
                    if (file == null) {
                        toast("Profile updated successfully", Toast.LENGTH_SHORT)
                    }
                    isProfileDataUpdated = true
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

    private val imagePickerLauncher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK) {
                var imageUri = it.data?.data!!
                binding.ivProfile.setImageURI(imageUri)

                file = File(imageUri.path!!)
            }
        }

}