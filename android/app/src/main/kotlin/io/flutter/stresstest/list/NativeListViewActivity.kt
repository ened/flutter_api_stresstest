package io.flutter.stresstest.list

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import io.flutter.stresstest.R
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterRunArguments
import kotlinx.android.synthetic.main.activity_native_list_view.*
import kotlinx.android.synthetic.main.content_native_list_view.*

class NativeListViewActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        FlutterMain.ensureInitializationComplete(applicationContext, emptyArray())

        val arguments = FlutterRunArguments()
        arguments.bundlePath = FlutterMain.findAppBundlePath(applicationContext)
        arguments.entrypoint = "main"

        setContentView(R.layout.activity_native_list_view)

        setSupportActionBar(toolbar)

        listView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        listView.adapter = ListAdapter(this, arguments)
    }

    override fun onDestroy() {
        super.onDestroy()

        // This is needed so that Adapter.onDetachedFromRecyclerView will be called.
        listView.adapter = null
    }
}

