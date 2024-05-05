package pe.edu.upc.flexistudentmobile.model.data

import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf

data class ReservationData(
    val roomId: Int,
    val date: String,
    val hourInit: String,
    val hourFinal: String,
    val phone: String,
    val email: String,
    val observation: String,
    val totalPrice: Double,
    val imageUrl: String,
    val arrenderId: Int
)

data class RequestReservationState(
    var roomId: Int = 0,
    var date: MutableState<String> = mutableStateOf(""),
    var hourInit: MutableState<String> = mutableStateOf(""),
    var hourFinal: MutableState<String> = mutableStateOf(""),
    var phone: MutableState<String> = mutableStateOf(""),
    var email: MutableState<String> = mutableStateOf(""),
    var observation: MutableState<String> = mutableStateOf(""),
    var totalPrice: Double = 0.0,
    var imageUrl: MutableState<String> = mutableStateOf(""),
    var arrenderId: Int = 0
)