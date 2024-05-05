package pe.edu.upc.flexistudentmobile.ui.room.roomlist

import android.annotation.SuppressLint
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.glide.GlideImage
import pe.edu.upc.flexistudentmobile.factories.room.RoomRepositoryFactory
import pe.edu.upc.flexistudentmobile.factories.student.repositories.StudentRepositoryFactory
import pe.edu.upc.flexistudentmobile.model.data.Room

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@Composable
fun RoomList(roomReserve:(Room)->Unit) {

    val roomList = remember {
        mutableStateOf<List<Room>>(emptyList())
    }

    val isFetchingRooms = remember {
        mutableStateOf(true)
    }

    Scaffold(

    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(it),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            LaunchedEffect (Unit){
                fetchRooms(roomList, isFetchingRooms)
            }

            if (roomList.value.isEmpty()) {
                Text(
                    text = "No hay habitaciones disponibles",
                    style = TextStyle(
                        color = MaterialTheme.colorScheme.primary,
                        fontSize = 20.sp
                    ),
                    modifier = Modifier
                        .padding(10.dp)
                )
            } else {
                RoomListById(roomList, roomReserve)
            }
        }
    }
}


@Composable
fun RoomListById(
    roomListById: MutableState<List<Room>>,
    roomReserve:(Room)->Unit
) {

    LazyColumn {
        items(roomListById.value) { room ->
            Card(
                modifier = Modifier
                    .fillMaxWidth(0.7f)
                    .padding(8.dp),
                colors = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                )
            ) {
                Column(
                    modifier = Modifier.fillMaxSize(),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    RoomImage(
                        url = room.imageUrl
                    )
                    Spacer(modifier = Modifier.height(10.dp))

                    Text(
                        text = room.title,
                        style= TextStyle(
                            color = Color.White,
                            fontWeight = FontWeight.Bold
                        ),
                        modifier=Modifier.padding(4.dp)
                    )

                    Text(
                        text = "S/. ${room.price} / hora",
                        style= TextStyle( color = Color.White),
                        modifier=Modifier.padding(4.dp)
                    )

                    Text(
                        text = "Cerca de ${room.nearUniversities}",
                        style= TextStyle( color = Color.White),
                        modifier=Modifier.padding(4.dp)
                    )

                    Spacer(modifier = Modifier.height(5.dp))

                    Button(
                        onClick = {
                            roomReserve(room)
                        },
                        colors = ButtonDefaults.buttonColors(
                            MaterialTheme.colorScheme.secondary
                        ),
                        modifier = Modifier.padding(bottom = 20.dp)

                    ) {
                        Text(
                            text = "Ver detalle",
                            style= TextStyle( color = Color.White),
                            modifier = Modifier.padding(4.dp)
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun RoomImage(url: String, modifier: Modifier = Modifier){
    GlideImage(
        imageModel={url},
        imageOptions= ImageOptions(contentScale= ContentScale.FillWidth),
        modifier = modifier.fillMaxWidth()
    )
}


suspend fun fetchRooms(roomList: MutableState<List<Room>>, isFetchingRooms: MutableState<Boolean>) {
    isFetchingRooms.value = true
    val maxRoomId = 20L
    val tempList = mutableListOf<Room>()

    val studentRepository = StudentRepositoryFactory.getStudentRepository("")
    val dataLocalStudent = studentRepository.getStudent()
    val roomListById = RoomRepositoryFactory.getRoomRepositoryFactory(dataLocalStudent[0].token)

    var fetchedRoomsCount = 0L

    for (roomId in 12L..maxRoomId) {
        roomListById.getRoomsById(roomId) { apiResponseRoom, errorCode, status ->
            if (apiResponseRoom != null) {
                tempList.addAll(apiResponseRoom.data)
            } else {
                println("Error fetching room with ID $roomId: $status")
            }

            fetchedRoomsCount++
            if (fetchedRoomsCount == maxRoomId - 11L) {
                roomList.value = tempList.toList()
                isFetchingRooms.value = !isFetchingRooms.value
            }
        }
    }
}
