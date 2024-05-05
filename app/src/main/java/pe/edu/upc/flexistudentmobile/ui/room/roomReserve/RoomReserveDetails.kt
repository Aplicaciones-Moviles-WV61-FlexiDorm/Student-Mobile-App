package pe.edu.upc.flexistudentmobile.ui.room.roomReserve

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DatePickerState
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.TimePickerState
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import pe.edu.upc.flexistudentmobile.model.data.RequestReservationState
import pe.edu.upc.flexistudentmobile.model.data.ReservationData
import pe.edu.upc.flexistudentmobile.model.data.Room
import pe.edu.upc.flexistudentmobile.ui.screens.shared.InputTextField

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RoomReserveDetails(
    room: Room,
    requestReservationState: RequestReservationState,
    onReservationConfirmed: () -> Unit
){
    val datePickerState = rememberDatePickerState()
    val timePickerStateInit = remember { mutableStateOf(TimePickerState(initialHour = 0, initialMinute = 0, is24Hour = true)) }
    val timePickerStateFinal = remember { mutableStateOf(TimePickerState(initialHour = 0, initialMinute = 0, is24Hour = true)) }


    val showDialogDate = remember { mutableStateOf(false) }
    val showDialogTimeInit = remember { mutableStateOf(false) }
    val showDialogTimeFinal = remember { mutableStateOf(false) }

    val email = remember {
        mutableStateOf("")
    }

    val phoneNumber = remember {
        mutableStateOf("")
    }

    val additionalDetails = remember {
        mutableStateOf("")
    }

    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(scrollState),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally

    ) {
        Text(
            text = "Reservar ${room.title}",
            style = TextStyle(
                color = MaterialTheme.colorScheme.tertiary,
                fontWeight = FontWeight.Bold,
            ),
            fontSize = 20.sp,
            modifier = Modifier.padding(10.dp)
        )

        Spacer(modifier = Modifier.height(5.dp))

        RoomImageReserve(
            url = room.imageUrl,
            size = 250.dp
        )

        DatePickerButton(
            state = datePickerState,
            showDialog = showDialogDate
        )

        Row {
            Text(
                text = "Hora inicio ",
                style = TextStyle(color = MaterialTheme.colorScheme.primary)
            )

            TimePickerButton(
                showDialog = showDialogTimeInit,
                label = "Seleccionar hora",
                onTimeSelected = { hour, minute ->
                    timePickerStateInit.value = TimePickerState(hour, minute, true)
                }
            )
        }

        Row {
            Text(
                text = "Hora fin ",
                style = TextStyle(color = MaterialTheme.colorScheme.primary)
            )

            TimePickerButton(
                showDialog = showDialogTimeFinal,
                label = "Seleccionar hora",
                onTimeSelected = { hour, minute ->
                    timePickerStateFinal.value = TimePickerState(hour, minute, true)
                }
            )
        }

        if (showDialogDate.value) {
            DatePickerDialog(
                onDismissRequest = { showDialogDate.value = false },
                confirmButton = {
                    Button(onClick = { showDialogDate.value = false }) {
                        Text("Aceptar")
                    }
                }
            ) {
                DatePicker(state = datePickerState)
            }
        }

        if (showDialogTimeInit.value) {
            TimePickerDialog(
                showDialog = showDialogTimeInit,
                onTimeSelected = { hour, minute ->
                    timePickerStateInit.value = TimePickerState(hour, minute, true)
                    showDialogTimeInit.value = false
                }
            )
        }

        if (showDialogTimeFinal.value) {
            TimePickerDialog(
                showDialog = showDialogTimeFinal,
                onTimeSelected = { hour, minute ->
                    timePickerStateFinal.value = TimePickerState(hour, minute, true)
                    showDialogTimeFinal.value = false
                }
            )
        }

        Row {
            Text(
                text = "Email",
                style = TextStyle(color = MaterialTheme.colorScheme.primary)
            )
            InputTextField(input = email, placeholder = "Email", 200.dp)
        }

        Row {
            Text(
                text = "Telefono",
                style = TextStyle(color = MaterialTheme.colorScheme.primary)
            )
            InputTextField(input = phoneNumber, placeholder = "Telefono", 200.dp)
        }

        Row {
            Text(
                text = "Detalles adicionales",
                style = TextStyle(color = MaterialTheme.colorScheme.primary)
            )
            InputTextField(input = additionalDetails, placeholder = "Details", 200.dp)
        }

        Spacer(modifier = Modifier.height(10.dp))

        Button(
            onClick = {
                val reservationData = ReservationData(
                    roomId = room.roomId,
                    date = datePickerState.selectedDateMillis?.toString() ?: "",
                    hourInit = "${timePickerStateInit.value.hour}:${timePickerStateInit.value.minute}",
                    hourFinal = "${timePickerStateFinal.value.hour}:${timePickerStateFinal.value.minute}",
                    phone = requestReservationState.phone.value,
                    email = requestReservationState.email.value,
                    observation = requestReservationState.observation.value,
                    totalPrice = room.price,
                    imageUrl = room.imageUrl,
                    arrenderId = room.arrenderId
                )

                onReservationConfirmed()
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text(
                text = "RESERVAR AHORA",
                style = TextStyle(color = MaterialTheme.colorScheme.background)
            )

        }
    }
}

@Composable
fun TimePickerDialog(
    showDialog: MutableState<Boolean>,
    onTimeSelected: (Int, Int) -> Unit
) {
    val hour = remember { mutableStateOf(0) }
    val minute = remember { mutableStateOf(0) }

    if (showDialog.value) {
        AlertDialog(
            onDismissRequest = { showDialog.value = false },
            title = { Text("Seleccionar hora") },
            confirmButton = {
                Button(
                    onClick = {
                        showDialog.value = false
                        onTimeSelected(hour.value, minute.value)
                    }
                ) {
                    Text("Aceptar")
                } },
            dismissButton = {
                Button(
                    onClick = { showDialog.value = false }
                ) {
                    Text("Cancelar")
                } },
            text = {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    OutlinedTextField(
                        value = hour.value.toString(),
                        onValueChange = { hour.value = it.toIntOrNull() ?: 0 },
                        label = { Text("Horas") },
                        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number),
                        modifier = Modifier.padding(8.dp)
                    )
                    OutlinedTextField(
                        value = minute.value.toString(),
                        onValueChange = { minute.value = it.toIntOrNull() ?: 0 },
                        label = { Text("Minutos") },
                        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number),
                        modifier = Modifier.padding(8.dp)
                    )
                }
            }
        )
    }

}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TimePickerButton(
    showDialog: MutableState<Boolean>,
    label: String,
    onTimeSelected: (Int, Int) -> Unit
) {
    Button(
        onClick = { showDialog.value = true }
    ) {
        Text(
            text = label,
            style = TextStyle(color = MaterialTheme.colorScheme.background)
        )
    }

    TimePickerDialog(
        showDialog = showDialog,
        onTimeSelected = onTimeSelected
    )
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DatePickerButton(
    state: DatePickerState,
    showDialog: MutableState<Boolean>
) {
    Row(
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = "Fecha de Reserva",
            style = TextStyle(color = MaterialTheme.colorScheme.primary)
        )

        Spacer(modifier = Modifier.width(8.dp))

        Button(
            onClick = {
                showDialog.value = true
            },
            modifier = Modifier.height(45.dp),
            shape = RoundedCornerShape(20.dp),
            colors = ButtonDefaults.buttonColors(
                contentColor = Color.White,
                containerColor = MaterialTheme.colorScheme.primary
            )
        ) {
            Text(text = "Seleccionar")
        }
    }
}






















