package com.android.gowild.ui.base

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.viewbinding.ViewBinding
import com.android.gowild.ui.user.dialog.ProgressDialog
import com.android.gowild.utils.local.UserPrefs
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
abstract class BaseFragment : Fragment() {

    @Inject
    lateinit var userPrefs: UserPrefs

    protected lateinit var mContext: Context

    private lateinit var progressDialog: ProgressDialog

    abstract fun getBinding(
        inflater: LayoutInflater,
        container: ViewGroup?
    ): ViewBinding

    override fun onAttach(context: Context) {
        super.onAttach(context)
        mContext = context
    }


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding = getBinding(inflater, container)
        return binding.root
    }

    protected fun showProgress() {
        try {
            if (this::progressDialog.isInitialized && progressDialog.isShowing) return
            progressDialog = ProgressDialog(mContext)
            progressDialog.show()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    protected fun hideProgress() {
        if (this::progressDialog.isInitialized && progressDialog.isShowing) progressDialog.dismiss()
    }
}