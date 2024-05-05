package pe.edu.upc.flexistudentmobile.animations

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay
import pe.edu.upc.flexistudentmobile.R


@Composable
fun SplashScreen1 (load:()->Unit){
    LaunchedEffect (key1 = true) {
        delay(3000)
        load()
    }

    Splash()
}

@Composable
fun Splash(){
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Image(
            painter = painterResource(id = R.drawable.logo1),
            contentDescription = "Logo",
            Modifier.size(250.dp, 250.dp)
        )

        Spacer(modifier = Modifier.height(10.dp))

        Image(
            painter = painterResource(id = R.drawable.logo2),
            contentDescription = "Logo Flexidorm",
            Modifier.size(200.dp, 150.dp)
        )
    }
}


@Composable
fun SplashScreen2(load:()->Unit){
    LaunchedEffect (key1 = true) {
        delay(3000)
        load()
    }

    Splash2()
}

@Composable
fun Splash2(){
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Image(
            painter = painterResource(id = R.drawable.logo1),
            contentDescription = "Logo",
            Modifier.size(250.dp, 250.dp)
        )

        Spacer(modifier = Modifier.height(10.dp))

        Text(
            text = "Cargando ...",
            fontSize = 30.sp,
            fontWeight = FontWeight.Bold,
            style= TextStyle(MaterialTheme.colorScheme.tertiary)
        )
    }
}