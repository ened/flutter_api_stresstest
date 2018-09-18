package io.flutter.stresstest.list

import android.support.v7.widget.RecyclerView
import android.view.View
import io.flutter.stresstest.R
import io.flutter.view.FlutterView

internal class NativeViewHolder(itemView: View?) : RecyclerView.ViewHolder(itemView) {
    var flutterActivated = false
    val nativeView: FlutterView = itemView!!.findViewById(R.id.nativeView)
}