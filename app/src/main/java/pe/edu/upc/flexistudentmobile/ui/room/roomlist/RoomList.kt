package pe.edu.upc.flexistudentmobile.ui.room.roomlist

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
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
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.glide.GlideImage
import pe.edu.upc.flexistudentmobile.factories.room.RoomRepositoryFactory
import pe.edu.upc.flexistudentmobile.factories.student.repositories.StudentRepositoryFactory
import pe.edu.upc.flexistudentmobile.model.data.Room

@Composable
fun RoomList() {
    val roomList = remember {
        mutableStateOf(listOf<Room>())
    }
    var roomId = 1

    val isFetchingRooms = remember {
        mutableStateOf(true)
    }

    Scaffold(

    ) {
        Column (
            modifier = Modifier.padding(it).fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            val studentRepository = StudentRepositoryFactory.getStudentRepository("")
            val dataLocalStudent = studentRepository.getStudent()
            val roomRepository = RoomRepositoryFactory.getRoomRepositoryFactory(dataLocalStudent[0].token)

            val tempList = mutableListOf<Room>()

            while (isFetchingRooms.value) {
                roomRepository.getRoomsById(roomId.toLong()) { response, _, _ ->
                    if (response != null) {
                        tempList.addAll(response.data)
                        roomId++
                    } else {
                        isFetchingRooms.value = !isFetchingRooms.value
                    }
                }
            }

            roomList.value = tempList.toList()


            if(roomList.value.isEmpty()){
                Text(
                    text = "No hay habitaciones disponibles",
                    style= TextStyle(
                        color = MaterialTheme.colorScheme.primary,
                        fontSize = 20.sp
                    ),
                    modifier=Modifier.padding(10.dp)
                )
            }else{
                RoomListById(roomList)
            }

        }
    }

}

@Composable
fun RoomListById(roomListById: MutableState<List<Room>>) {
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
                    roomImage(
                        url = room.imageUrl,
                        size = 120.dp
                    )
                    Text(
                        text = room.title,
                        style= TextStyle( color = Color.White),
                        modifier=Modifier.padding(4.dp)
                    )

                    Text(
                        text = "S/. ${room.price} x hora",
                        style= TextStyle( color = Color.White),
                        modifier=Modifier.padding(4.dp)
                    )

                    Text(
                        text = "Cerca de ${room.nearUniversities}",
                        style= TextStyle( color = Color.White),
                        modifier=Modifier.padding(4.dp)
                    )
                }
            }
        }
    }
}

@Composable
fun roomImage(url: String, size: Dp){
    GlideImage(
        imageModel={url},
        imageOptions= ImageOptions(contentScale= ContentScale.Crop),
        modifier= Modifier.size(size)
    )
}