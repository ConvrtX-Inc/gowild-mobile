package com.android.gowild.ui.support

import android.app.Activity
import android.net.Uri
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.support.SupportCreateNewTicketRequestModel
import com.android.gowild.databinding.FragmentSendNewTicketBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.github.drjacky.imagepicker.ImagePicker
import com.github.drjacky.imagepicker.constant.ImageProvider
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.File

class SendNewTicketFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = SendNewTicketFragment()
    }

    lateinit var binding: FragmentSendNewTicketBinding
    var imagesList: ArrayList<Uri> = ArrayList()
    lateinit var imagesAdapter: BindingRecyclerAdapter<Uri, SimpleCallbackValue>
    private val supportVM: SupportVM by viewModels()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentSendNewTicketBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setAdapter()
        setListener()
        setupObservers()
    }

    private fun setAdapter() {
        imagesAdapter = BindingRecyclerAdapter(
            R.layout.item_list_support_attach_images,
            imagesList,
            null,
            SimpleCallbackValue { position ->
                imagesList.removeAt(position as Int)
                imagesAdapter.notifyDataSetChanged()
            })
        val gridLayoutManager = GridLayoutManager(requireContext(), 3, RecyclerView.VERTICAL, false)
        binding.rvImages.layoutManager = gridLayoutManager
        binding.rvImages.adapter = imagesAdapter
    }

    private fun setListener() {
        binding.ivCamera.setOnClickListener {
            ImagePicker.with(requireActivity()).crop().maxResultSize(1000, 1000)
                .provider(ImageProvider.BOTH).setMultipleAllowed(true)
                .createIntentFromDialog { intent ->
                    launcher.launch(intent)
                }
        }

        binding.btnSendMessage.setOnClickListener {
            if (validateInputFields()) {
                supportVM.createNewTicket(
                    SupportCreateNewTicketRequestModel(
                        binding.etMessage.text.toString(),
                        binding.etSubject.text.toString()
                    )
                )
            }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun validateInputFields(): Boolean {
        if (binding.etSubject.text.isEmpty()) {
            binding.etSubject.error = "Subject cannot be empty"
            return false
        } else if (binding.etMessage.text.isEmpty()) {
            binding.etMessage.error = "Message cannot be empty"
            return false
        }
        return true
    }

    private val launcher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == Activity.RESULT_OK) {
                if (it.data?.hasExtra(ImagePicker.EXTRA_FILE_PATH)!!) {
                    if (imagesList.size < 3) {
                        val files = it.data?.data!!
                        imagesList.add(files)
                        imagesAdapter.notifyDataSetChanged()
                    } else {
                        toast("Maximum three images allowed")
                    }
                } else if (it.data?.hasExtra(ImagePicker.MULTIPLE_FILES_PATH)!!) {
                    val files = ImagePicker.getAllFile(it.data) as ArrayList<Uri>
                    for (file in files) {
                        if (imagesList.size < 3) {
                            imagesList.add(file)
                            imagesAdapter.notifyDataSetChanged()
                        } else {
                            toast("Maximum three images allowed")
                            break
                        }
                    }
                }
            }
        }

    private fun setupObservers() {
        observeCreateSupportTicketResponse()
        observeUpdateTicketResponse()
    }

    private fun observeUpdateTicketResponse() {
        supportVM.supportUpdateTicketImageResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    hideProgress()
                    toast(response.data!!.message, Toast.LENGTH_SHORT)
                    requireActivity().onBackPressedDispatcher.onBackPressed()
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

    private fun observeCreateSupportTicketResponse() {
        supportVM.supportCreateNewTicketResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    if (imagesList.isNotEmpty()) {
                        supportVM.updateTicketImages(
                            response.data!!.data.id,
                            response.data.data.message_id.toRequestBody("text/plain".toMediaType()),
                            getImagesPart()
                        )
                    } else {
                        toast("Ticket created successfully", Toast.LENGTH_SHORT)
                        requireActivity().onBackPressedDispatcher.onBackPressed()
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

    private fun getImagesPart(): ArrayList<MultipartBody.Part> {
        val imagesPart: ArrayList<MultipartBody.Part> = ArrayList()
        for (image in imagesList) {
            val file = File(image.path!!)
            imagesPart.add(
                MultipartBody.Part.createFormData(
                    "attachment", file.name, file.asRequestBody("image/*".toMediaType())
                )
            )
        }
        return imagesPart
    }
}