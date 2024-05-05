package pe.edu.upc.flexistudentmobile.ui.room.roomReserve

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.glide.GlideImage
import pe.edu.upc.flexistudentmobile.model.data.Room

@Composable
fun RoomReserve(
    room: Room,
    navigateReserve:()->Unit
){
    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {

        Text(
            text = room.title,
            style= TextStyle(
                color = MaterialTheme.colorScheme.tertiary,
                fontWeight = FontWeight.Bold,
            ),
            fontSize = 20.sp,
            modifier = Modifier.padding(10.dp)
        )

        RoomImageReserve(
            url = room.imageUrl,
            size = 350.dp
        )

        Spacer(modifier = Modifier.height(20.dp))

        Text(
            text = "Precio: ${room.price}",
            style= TextStyle(
                color = MaterialTheme.colorScheme.tertiary,
            ),
            modifier = Modifier
                .padding(bottom = 5.dp)
        )

        Text(
            text = "Descripcion: ${room.description}",
            style= TextStyle(
                color = MaterialTheme.colorScheme.tertiary,
            ),
            modifier = Modifier
                .padding(bottom = 5.dp)
        )

        Text(
            text = "Ubicacion: ${room.address}",
            style= TextStyle(
                color = MaterialTheme.colorScheme.tertiary,
            ),
            modifier = Modifier.padding(bottom = 5.dp)
        )

        Spacer(modifier = Modifier.height(10.dp))

        Button(
            onClick = {
                navigateReserve()
            },
            colors = ButtonDefaults.buttonColors(
                MaterialTheme.colorScheme.secondary
            ),
            modifier = Modifier.padding(bottom = 10.dp)
        ) {
            Text(
                text = "Reservar",
                style= TextStyle( color = Color.White),
                modifier = Modifier.padding(5.dp)
            )
        }
    }
}

@Composable
fun RoomImageReserve(url: String, size: Dp){
    GlideImage(
        imageModel={url},
        imageOptions= ImageOptions(
            contentScale= ContentScale.Crop,
        ),
        modifier= Modifier
            .size(size)
            .clip(RoundedCornerShape(8.dp))
    )
}