package pe.edu.upc.flexistudentmobile.model.remote
import pe.edu.upc.flexistudentmobile.model.data.ApiResponseRoomList
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.Path
import retrofit2.http.Query

interface RoomService {
    @GET("room/getRoomsByRoomId/{roomId}")

    fun getRoomsByRoomId(
        @Header("Authorization") token:String,
        @Path("roomId") roomId:Long
    ): Call<ApiResponseRoomList>
}