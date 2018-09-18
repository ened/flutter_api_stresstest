package io.flutter.stresstest.list

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import io.flutter.view.FlutterRunArguments
import io.flutter.stresstest.R

internal class ListAdapter(context: Context, private val arguments: FlutterRunArguments) : RecyclerView.Adapter<NativeViewHolder>() {
    companion object {
        const val TAG = "ListAdapter"
    }

    private val inflater: LayoutInflater = LayoutInflater.from(context)

    override fun getItemCount(): Int = 12

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NativeViewHolder {
        Log.d(TAG, "onCreateViewHolder: $parent, $viewType")

        return NativeViewHolder(inflater.inflate(R.layout.list_item_native_view, parent, false))
    }

    override fun onBindViewHolder(holder: NativeViewHolder, position: Int) {
        Log.d(TAG, "onBindViewHolder: $holder, $position")

        if (!holder.flutterActivated) {
            holder.nativeView.setInitialRoute("/native-test-element/$position")
            holder.nativeView.runFromBundle(arguments)
            holder.flutterActivated = true
        } else {
            // push or replace?
            holder.nativeView.pushRoute("/native-test-element/$position")
        }

    }

    override fun onFailedToRecycleView(holder: NativeViewHolder): Boolean {
        Log.d(TAG, "onFailedToRecycleView: $holder")

        return super.onFailedToRecycleView(holder)
    }

    override fun onViewRecycled(holder: NativeViewHolder) {
        Log.d(TAG, "onViewRecycled: $holder")

        super.onViewRecycled(holder)
    }

    override fun onViewAttachedToWindow(holder: NativeViewHolder) {
        Log.d(TAG, "onViewAttachedToWindow: $holder")

        super.onViewAttachedToWindow(holder)

        holder.nativeView.onStart()
        holder.nativeView.onFirstFrame()
        holder.nativeView.onPostResume()
    }

    override fun onViewDetachedFromWindow(holder: NativeViewHolder) {
        Log.d(TAG, "onViewDetachedFromWindow: $holder")

        super.onViewDetachedFromWindow(holder)

        holder.nativeView.onStop()
    }

    override fun onDetachedFromRecyclerView(recyclerView: RecyclerView) {
        Log.d(TAG, "onDetachedFromRecyclerView: $recyclerView")

        super.onDetachedFromRecyclerView(recyclerView)

        0.rangeTo(itemCount).forEach {
            val holder: NativeViewHolder? = recyclerView.findViewHolderForAdapterPosition(it) as? NativeViewHolder

            Log.d(TAG, "FlutterView.destroy: $it")

            holder?.nativeView?.destroy()
        }
    }
}