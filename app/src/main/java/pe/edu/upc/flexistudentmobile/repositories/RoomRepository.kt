package pe.edu.upc.flexistudentmobile.repositories

import pe.edu.upc.flexistudentmobile.model.data.ApiResponseRoomList
import pe.edu.upc.flexistudentmobile.model.remote.RoomService
import retrofit2.Call
import retrofit2.Callback
import retrofit2.HttpException
import retrofit2.Response

class RoomRepository (
    private val roomService: RoomService,
    private val token: String
) {
    fun getRoomsById(
        roomId:Long,
        callback: (ApiResponseRoomList?, Int?, String?) -> Unit
    ) {
        val call = roomService.getRoomsByRoomId("Bearer $token",roomId)

        call.enqueue(object : Callback<ApiResponseRoomList> {
            override fun onResponse(call: Call<ApiResponseRoomList>, response: Response<ApiResponseRoomList>) {
                if (response.isSuccessful) {

                    val apiResponseRoom = response.body()
                    val statusCode= response.code()
                    callback(apiResponseRoom, statusCode, null)

                } else {
                    val errorCode = response.code()
                    val errorBody = response.errorBody()?.string()
                    callback(null, errorCode, errorBody)
                }
            }

            override fun onFailure(call: Call<ApiResponseRoomList>, t: Throwable) {
                var errorCode = -1
                if (t is HttpException) {
                    errorCode = t.code()
                }
                callback(null, errorCode, t.message)
            }
        })
    }
}