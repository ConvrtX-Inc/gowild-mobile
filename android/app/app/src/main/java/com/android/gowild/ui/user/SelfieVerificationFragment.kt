package com.android.gowild.ui.user

import android.Manifest.permission.CAMERA
import android.Manifest.permission.WRITE_EXTERNAL_STORAGE
import android.content.ContentValues
import android.content.Context
import android.graphics.*
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.util.Rational
import android.util.Size
import android.view.LayoutInflater
import android.view.Surface.ROTATION_0
import android.view.ViewGroup
import android.webkit.MimeTypeMap
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageCapture
import androidx.camera.core.ImageCaptureException
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentSelfieVerificationBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.TIME_FORMAT_TIME_STAMP
import com.android.gowild.utils.extension.*
import com.google.android.material.snackbar.Snackbar
import com.google.common.util.concurrent.ListenableFuture
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import timber.log.Timber
import java.io.*
import java.text.SimpleDateFormat
import java.util.*


class SelfieVerificationFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = SelfieVerificationFragment()
    }

    private lateinit var file: File
    lateinit var binding: FragmentSelfieVerificationBinding

    private val selfieVerificationViewModel: SelfieVerificationVM by viewModels()

    private lateinit var cameraProviderFuture: ListenableFuture<ProcessCameraProvider>
    private lateinit var cameraSelector: CameraSelector
    private var imageCapture: ImageCapture? = null

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentSelfieVerificationBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        initCamera()
        setCallbacks()
        observeSelfieVerification()
    }

    private fun setCallbacks() {
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        binding.btnSubmit.setOnClickListener {
            takePhoto()
        }
    }

    private val cameraProviderResult = registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
        var granted = false
        permissions.entries.forEach {
            granted = it.value
        }
        if (granted) {
            startCamera()
        } else {
            Snackbar.make(binding.root, "Pleas allow required permissions", Snackbar.LENGTH_INDEFINITE).show()
        }
    }

    private fun initCamera() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            cameraProviderResult.launch(arrayOf(CAMERA))
        } else {
            cameraProviderResult.launch(arrayOf(CAMERA, WRITE_EXTERNAL_STORAGE))
        }
        cameraProviderFuture = ProcessCameraProvider.getInstance(requireContext())
        cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA
    }

    private fun startCamera() {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(requireContext())

        cameraProviderFuture.addListener({
            val cameraProvider: ProcessCameraProvider = cameraProviderFuture.get()

            val preview = Preview.Builder().build().also {
                it.setSurfaceProvider(binding.cameraView.surfaceProvider)
            }

            imageCapture = ImageCapture.Builder().setTargetRotation(ROTATION_0).setTargetResolution(Size(600, 600)).setJpegQuality(50).build()


            val cameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA


            try {
                cameraProvider.unbindAll()
                cameraProvider.bindToLifecycle(
                    this, cameraSelector, preview, imageCapture
                )
            } catch (exc: Exception) {
                toast("Unable to start camera")
            }

        }, ContextCompat.getMainExecutor(requireContext()))
    }

    private fun takePhoto() {
        val imageCapture = imageCapture ?: return

        imageCapture.setCropAspectRatio(Rational(1, 1))

        val time = SimpleDateFormat(TIME_FORMAT_TIME_STAMP, Locale.getDefault()).format(System.currentTimeMillis())
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, "go_wild_selfie")
//            put(MediaStore.MediaColumns.DISPLAY_NAME, "selfie_$time")
            put(MediaStore.MediaColumns.MIME_TYPE, "image/png")
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
                put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/GoWildHistory")
            }
        }

        val outputOptions = ImageCapture.OutputFileOptions.Builder(
            requireActivity().contentResolver, MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues
        ).build()

        imageCapture.takePicture(outputOptions, ContextCompat.getMainExecutor(requireContext()), object : ImageCapture.OnImageSavedCallback {
            override fun onError(exc: ImageCaptureException) {
                Toast.makeText(requireContext(), "Photo capture failed: ${exc.message}", Toast.LENGTH_SHORT).show()
            }

            override fun onImageSaved(output: ImageCapture.OutputFileResults) {
                if (output.savedUri != null && output.savedUri != null) {
                    Timber.tag("SELFIE_VERIFICATION").wtf("${output.savedUri}")
                    binding.ivCapturedImage.visible()
//                    binding.ivCapturedImage.setImageURI(output.savedUri)


                    val bitmap = getThumbnail(output.savedUri!!)
                    Timber.tag("IMAGE_SIZES").wtf("bitmap        ${bitmap!!.byteCount}")

                    val rotatedBitmap = rotateBitmap(bitmap!!, -90f)
                    Timber.tag("IMAGE_SIZES").wtf("rotatedBitmap ${rotatedBitmap.byteCount}")

                    val flippedBitmap = flip(rotatedBitmap, xFlip = true, yFlip = false)
                    Timber.tag("IMAGE_SIZES").wtf("flippedBitmap ${flippedBitmap!!.byteCount}")

                    file = compressBitmap(flippedBitmap!!)
//                    val rotatedBitmap = bitmap.


                    binding.ivCapturedImage.setImageBitmap(flippedBitmap)
//                    binding.ivCapturedImage.loadImage(output.savedUri)
//                    Glide
//                        .with(requireContext())
//                        .load(output.savedUri)
//                        .into(binding.ivCapturedImage)

//                    file = getFileFromContentUri(requireContext(), output.savedUri!!)
                    selfieVerificationViewModel.userImageVerification(
                        MultipartBody.Part.createFormData(
                            "image1",
                            file.name,
                            file.asRequestBody("image/*".toMediaType())
                        ),
                        MultipartBody.Part.createFormData(
                            "image2",
                            file.name,
                            file.asRequestBody("image/*".toMediaType())
                        )
                    )
                }
            }
        })
    }

    private fun observeSelfieVerification() {
        selfieVerificationViewModel.userImageVerificationResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    toast(response.data!!.message)
                    if (response.data.selfie_verified) {
                        val user = userPrefs.getUser()!!
                        user.selfie_verified = response.data!!.selfie_verified
                        userPrefs.saveUser(user)
                        userPrefs.getUser()!!.selfie_verified = response.data!!.selfie_verified

                        requireActivity().onBackPressedDispatcher.onBackPressed()
                    } else {
                        binding.ivCapturedImage.gone()
                    }
                }
                is NetworkResult.Failure -> {
                    binding.ivCapturedImage.gone()
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
                    binding.ivCapturedImage.gone()
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

    fun getFileFromContentUri(context: Context, contentUri: Uri): File {
        // Preparing Temp file name
        val fileExtension = getFileExtension(context, contentUri)
        val fileName = "temp_file" + if (fileExtension != null) ".$fileExtension" else ""

        // Creating Temp file
        val tempFile = File(context.cacheDir, fileName)
        tempFile.createNewFile()

        try {
            val oStream = FileOutputStream(tempFile)
            val inputStream = context.contentResolver.openInputStream(contentUri)

            inputStream?.let {
                copy(inputStream, oStream)
            }
            val bitmap = BitmapFactory.decodeStream(inputStream)

            oStream.flush()
            inputStream?.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return tempFile
    }

    private fun getFileExtension(context: Context, uri: Uri): String? {
        val fileType: String? = context.contentResolver.getType(uri)
        return MimeTypeMap.getSingleton().getExtensionFromMimeType(fileType)
    }

    @Throws(IOException::class)
    private fun copy(source: InputStream, target: OutputStream) {
        val buf = ByteArray(8192)
        var length: Int
        while (source.read(buf).also { length = it } > 0) {
            target.write(buf, 0, length)
        }
    }


    @Throws(FileNotFoundException::class, IOException::class)
    fun getThumbnail(uri: Uri): Bitmap? {
        val THUMBNAIL_SIZE = 600.0
        var input: InputStream = requireContext().contentResolver.openInputStream(uri)!!
        val onlyBoundsOptions = BitmapFactory.Options()
        onlyBoundsOptions.inJustDecodeBounds = true
//        onlyBoundsOptions.inDither = true //optional
        onlyBoundsOptions.inPreferredConfig = Bitmap.Config.ARGB_8888 //optional
        BitmapFactory.decodeStream(input, null, onlyBoundsOptions)
        input.close()
        if (onlyBoundsOptions.outWidth == -1 || onlyBoundsOptions.outHeight == -1) {
            return null
        }
        val originalSize = if (onlyBoundsOptions.outHeight > onlyBoundsOptions.outWidth) onlyBoundsOptions.outHeight else onlyBoundsOptions.outWidth
        val ratio = if (originalSize > THUMBNAIL_SIZE) originalSize / THUMBNAIL_SIZE else 1.0
        val bitmapOptions = BitmapFactory.Options()
        bitmapOptions.inSampleSize = getPowerOfTwoForSampleRatio(ratio)
//        bitmapOptions.inDither = true //optional
        bitmapOptions.inPreferredConfig = Bitmap.Config.ARGB_8888 //
        input = requireContext().contentResolver.openInputStream(uri)!!
        val bitmap = BitmapFactory.decodeStream(input, null, bitmapOptions)
        input.close()
        return bitmap
    }

    private fun getPowerOfTwoForSampleRatio(ratio: Double): Int {
        val k = Integer.highestOneBit(Math.floor(ratio).toInt())
        return if (k == 0) 1 else k
    }

    private fun flip(source: Bitmap, xFlip: Boolean, yFlip: Boolean): Bitmap? {
        val matrix = Matrix()
        matrix.postScale(if (xFlip) -1f else 1f, if (yFlip) -1f else 1f, source.width / 2f, source.height / 2f)
        return Bitmap.createBitmap(source, 0, 0, source.width, source.height, matrix, true)
    }

    fun rotateBitmap(source: Bitmap, degrees: Float): Bitmap {
        val matrix = Matrix()
        matrix.postRotate(degrees)
        return Bitmap.createBitmap(
            source, 0, 0, source.width, source.height, matrix, true
        )
    }

    fun compressBitmap(bitmap: Bitmap): File {
        val file = File(requireContext().cacheDir, "temp.png")
        file.createNewFile()

        val bos = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 50 /*ignored for PNG*/, bos);

        val bitmapData = bos.toByteArray()
        Timber.tag("IMAGE_SIZES").wtf("compressBitmap ${bitmapData.size}")

        val fos = FileOutputStream(file)
        fos.write(bitmapData)
        fos.flush()
        fos.close()
        return file
    }
}