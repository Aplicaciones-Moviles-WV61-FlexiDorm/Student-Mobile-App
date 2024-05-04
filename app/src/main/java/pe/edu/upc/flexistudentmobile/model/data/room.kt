package pe.edu.upc.flexistudentmobile.model.data

data class ApiResponseRoom(
    val message: String,
    val status: String,
    val data: Room
)

data class ApiResponseRoomList(
    val message: String,
    val status: String,
    val data: List<Room>
)

data class Room(
    val roomId: Int,
    val title:String,
    val description: String,
    val address: String,
    val imageUrl:String,
    val price: Double,
    val nearUniversities:String,
    val arrenderId: Int
)
