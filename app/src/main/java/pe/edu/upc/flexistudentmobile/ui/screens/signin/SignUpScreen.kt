package pe.edu.upc.flexistudentmobile.ui.screens.signin

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
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
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import pe.edu.upc.flexistudentmobile.factories.repositories.StudentRepositoryFactory
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentBody
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentState
import pe.edu.upc.flexistudentmobile.shared.MessageError
import java.util.Calendar
import java.util.Date
import java.util.TimeZone

@Composable
fun SignUpFirstScreen (
    requestSignUpStudent: RequestSignUpStudentState,
    errorMessageModel: MutableState<String?>,
    secontStep: () -> Unit,
    signInStep:() -> Unit
){
    val confirmPassword = remember {
        mutableStateOf("")
    }

    Scaffold { paddingValues ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .background(color = MaterialTheme.colorScheme.primary),
            contentAlignment = Alignment.Center
            ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth(0.85f)
                    .fillMaxHeight(0.8f),
                colors = CardDefaults.cardColors(
                    containerColor = Color.White,
                ),
                shape = RoundedCornerShape(20.dp),

            ) {
                Column (
                    modifier= Modifier
                        .fillMaxSize()
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,

                    ) {
                    Spacer(modifier = Modifier
                        .height(20.dp))

                    Text(
                        text = "Bienvenido a FlexiDorm!",
                        style = TextStyle(
                            fontWeight = FontWeight.Bold,
                            fontSize = 24.sp,
                            textAlign = TextAlign.Center,
                            color = MaterialTheme.colorScheme.primary
                        )
                    )
                    Text(
                        text = "Estudiante",
                        style = TextStyle(
                            fontWeight = FontWeight.Bold,
                            fontSize = 24.sp,
                            textAlign = TextAlign.Center,
                            color = MaterialTheme.colorScheme.primary),

                    )

                    Spacer(modifier = Modifier.height(60.dp))


                    Text(
                        text = "Ingresa tus datos para iniciar",
                        style= TextStyle( color = MaterialTheme.colorScheme.primary)
                    )

                    Spacer(modifier = Modifier.height(30.dp))

                    OutlinedTextField(
                        value = requestSignUpStudent.email.value,
                        onValueChange = {
                            requestSignUpStudent.email.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(
                            color = MaterialTheme.colorScheme.primary,
                            fontSize = 15.sp
                        ),
                        label = {
                            Text("Correo institucional",
                            color = MaterialTheme.colorScheme.primary)
                        },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors = OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    OutlinedTextField(
                        value = requestSignUpStudent.password.value,
                        onValueChange = {
                            requestSignUpStudent.password.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(
                            color = MaterialTheme.colorScheme.primary,
                            fontSize = 15.sp
                        ),
                        label = {
                            Text("Contraseña",
                            color = MaterialTheme.colorScheme.primary)
                        },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors=OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    OutlinedTextField(
                        value = confirmPassword.value,
                        onValueChange = {
                            confirmPassword.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(
                            color = MaterialTheme.colorScheme.primary,
                            fontSize = 15.sp
                        ),
                        label = {
                            Text("Confirma tu contraseña",
                            color = MaterialTheme.colorScheme.primary)
                        },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors=OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    Spacer(modifier = Modifier.height(60.dp))

                    Button(
                        shape= RoundedCornerShape(8.dp),
                        colors= ButtonDefaults.buttonColors(
                            contentColor =Color.White,
                            containerColor = MaterialTheme.colorScheme.primary
                        ),
                        onClick = {
                            if (requestSignUpStudent.email.value.isEmpty() || requestSignUpStudent.password.value.isEmpty() || confirmPassword.value.isEmpty()) {
                                errorMessageModel.value = "Los campos no pueden estar vacios"
                                return@Button
                            }

                            if (requestSignUpStudent.password.value != confirmPassword.value) {
                                errorMessageModel.value = "Las contraseñas no coinciden"
                                return@Button
                            }
                            secontStep()

                        }) {
                        Text("Continuar")
                    }

                    Spacer(modifier = Modifier.height(30.dp))


                    Row {
                        Text(text = "¿Ya tienes una cuenta?",style=TextStyle(color = MaterialTheme.colorScheme.primary))
                        Text(
                            text = "Inicia sesión",
                            modifier = Modifier.padding(horizontal = 3.dp).clickable {
                                signInStep()
                            },
                            style = TextStyle(
                                textDecoration = TextDecoration.Underline,
                                fontSize = 15.sp,
                                color = MaterialTheme.colorScheme.primary)
                        )
                    }

                    MessageError(errorMessageModel, "Espera un momento!")
                }
            }
        }

    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SignUpSecondScreen (
    requestSignUpArrenderState: RequestSignUpStudentState,
    errorMessageModel: MutableState<String?>,
    pressOnBack:()->Unit,
    navigationToSignIn:()->Unit
) {

    val state = rememberDatePickerState()
    val showDialog = remember { mutableStateOf(false) }
    val year = remember{mutableStateOf(0)}
    val month = remember{mutableStateOf(0)}
    val day = remember{mutableStateOf(0)}

    var isExpanded = remember { mutableStateOf(false) }
    val selectedOption = remember { mutableStateOf("") }
    val dialogTitle= remember { mutableStateOf("") }

    Scaffold { paddingValues ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .background(color = MaterialTheme.colorScheme.primary),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth(0.85f)
                    .fillMaxHeight(0.8f),
                colors= CardDefaults.cardColors(
                    containerColor=Color.White
                )
            ) {

                Column(
                    modifier= Modifier
                        .fillMaxSize()
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ){
                    Text(
                        text = "Estas a un paso de usar FlexiDorm",
                        style = TextStyle(
                            fontWeight = FontWeight.Bold,
                            fontSize = 24.sp,
                            color = MaterialTheme.colorScheme.primary
                        )
                    )

                    Text(
                        text = "Estas listo estudiante?",
                        style= TextStyle( color = MaterialTheme.colorScheme.primary),
                        modifier = Modifier
                            .padding(10.dp)
                    )

                    OutlinedTextField(
                        value = requestSignUpArrenderState.firstname.value,
                        onValueChange = {
                            requestSignUpArrenderState.firstname.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(color = MaterialTheme.colorScheme.primary, fontSize = 15.sp),
                        label = {
                            Text(
                                "Nombre",
                                color = MaterialTheme.colorScheme.primary
                            )
                        },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors=OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    OutlinedTextField(
                        value = requestSignUpArrenderState.lastname.value,
                        onValueChange = {
                            requestSignUpArrenderState.lastname.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(
                            color = MaterialTheme.colorScheme.primary,
                            fontSize = 15.sp
                        ),
                        label = {
                            Text(
                                "Apellido",
                                color = MaterialTheme.colorScheme.primary
                            ) },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors=OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    OutlinedTextField(
                        value = requestSignUpArrenderState.phoneNumber.value,
                        onValueChange = {
                            requestSignUpArrenderState.phoneNumber.value = it
                        },
                        modifier=Modifier.height(60.dp),
                        textStyle = TextStyle(color = Color(0xFF846CD9), fontSize = 15.sp),
                        label = { Text("Celular", color = MaterialTheme.colorScheme.primary) },
                        shape = RoundedCornerShape(15.dp),
                        singleLine = true,
                        colors=OutlinedTextFieldDefaults.colors(
                            unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                        )
                    )

                    Spacer(modifier = Modifier.height(10.dp))


                    Row {
                        Column {
                            Text(
                                text = "Fecha de nacimiento",
                                style = TextStyle(color = MaterialTheme.colorScheme.primary)
                            )

                            Spacer(modifier = Modifier.height(3.dp))

                            Button(
                                modifier=Modifier.height(45.dp).padding(0.dp),
                                shape= RoundedCornerShape(20.dp),
                                colors= ButtonDefaults.buttonColors(
                                    contentColor =Color.White,
                                    containerColor = MaterialTheme.colorScheme.primary
                                ),
                                onClick = {
                                    showDialog.value=true
                                }) {
                                Text(text = "Seleccionar")
                            }

                            if(showDialog.value){
                                DatePickerDialog(
                                    onDismissRequest = {
                                        showDialog.value=false
                                    },
                                    confirmButton = {
                                        Button(onClick = {
                                            showDialog.value=false
                                        }) {
                                            Text("Aceptar")
                                        }
                                    }
                                ){
                                    DatePicker(
                                        state=state
                                    )
                                }
                            }

                            val dateMilliseconds = state.selectedDateMillis
                            if (dateMilliseconds != null) {
                                val date = Date(dateMilliseconds)
                                val calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC")).apply { time = date }

                                year.value = calendar.get(Calendar.YEAR)
                                month.value = calendar.get(Calendar.MONTH) + 1
                                day.value = calendar.get(Calendar.DAY_OF_MONTH)
                            }

                            if (year.value != 0 && month.value != 0 && day.value != 0) {
                                val formattedDay = day.value.toString().padStart(2, '0')
                                val formattedMonth = month.value.toString().padStart(2, '0')
                                requestSignUpArrenderState.birthDate.value = "${year.value}-$formattedMonth-$formattedDay"
                                Text(text = "$formattedDay-$formattedMonth-${year.value}",style= TextStyle(fontSize = (13.sp), color = Color(0xFF846CD9)))
                            }

                        }

                        Spacer(modifier = Modifier.width(20.dp))

                        Column {

                            Text(
                                text = "Genero",
                                style = TextStyle(color = MaterialTheme.colorScheme.primary)
                            )

                            ExposedDropdownMenuBox(
                                expanded = isExpanded.value,
                                onExpandedChange ={isExpanded.value=it},
                                modifier= Modifier
                                    .width(145.dp)
                                    .height(52.dp)
                                    .padding(3.dp)
                            ) {
                                TextField(
                                    value = selectedOption.value,
                                    onValueChange ={},
                                    readOnly = true,
                                    trailingIcon = {
                                        ExposedDropdownMenuDefaults.TrailingIcon(
                                            expanded = isExpanded.value
                                        )
                                    },
                                    colors = ExposedDropdownMenuDefaults.textFieldColors(),
                                    modifier=Modifier.menuAnchor(),
                                    placeholder = {
                                        Text("Seleccionar",
                                        style= TextStyle(fontSize = (13.sp)))
                                    },
                                    textStyle = TextStyle(fontSize = (13.sp))
                                )
                                ExposedDropdownMenu(
                                    expanded =isExpanded.value ,
                                    onDismissRequest = { isExpanded.value = false },
                                    modifier = Modifier.width(145.dp)
                                ) {
                                    DropdownMenuItem(
                                        text = {
                                            Text(
                                                text = "MALE",
                                                style= TextStyle(fontSize = (13.sp))
                                            )
                                        },
                                        onClick = {
                                            selectedOption.value="MALE"
                                            isExpanded.value=false
                                        }
                                    )
                                    DropdownMenuItem(
                                        text = {
                                            Text(text = "FEMALE",
                                            style= TextStyle(fontSize = (13.sp)))
                                        },
                                        onClick = {
                                            selectedOption.value="FEMALE"
                                            isExpanded.value=false
                                        }
                                    )

                                }
                            }
                        }
                    }
                    Spacer(modifier = Modifier.height(10.dp))
                    requestSignUpArrenderState.gender.value=selectedOption.value

                    Button(
                        colors = ButtonDefaults.buttonColors(
                            contentColor =Color.White,
                            containerColor = MaterialTheme.colorScheme.primary
                        ),
                        onClick = {
                            if (
                                requestSignUpArrenderState.firstname.value.isEmpty() ||
                                requestSignUpArrenderState.lastname.value.isEmpty() ||
                                requestSignUpArrenderState.username.value.isEmpty() ||
                                requestSignUpArrenderState.phoneNumber.value.isEmpty() ||
                                requestSignUpArrenderState.email.value.isEmpty() ||
                                requestSignUpArrenderState.password.value.isEmpty() ||
                                requestSignUpArrenderState.address.value.isEmpty() ||
                                requestSignUpArrenderState.birthDate.value.isEmpty() ||
                                requestSignUpArrenderState.gender.value.isEmpty()
                            ) {
                                errorMessageModel.value = "Por favor, llena todos los campos"
                                dialogTitle.value="Espera un momento!"
                                return@Button
                            }

                            val body = RequestSignUpStudentBody(
                                firstname = requestSignUpArrenderState.firstname.value,
                                lastname = requestSignUpArrenderState.lastname.value,
                                username = requestSignUpArrenderState.username.value,
                                phoneNumber = requestSignUpArrenderState.phoneNumber.value,
                                email = requestSignUpArrenderState.email.value,
                                password = requestSignUpArrenderState.password.value,
                                address = requestSignUpArrenderState.address.value,
                                birthDate = requestSignUpArrenderState.birthDate.value,
                                profilePicture = requestSignUpArrenderState.profilePicture.value,
                                gender = requestSignUpArrenderState.gender.value,
                                university = requestSignUpArrenderState.university.value
                            )


                            val arrenderRepository= StudentRepositoryFactory.getStudentRepository("")

                            arrenderRepository.signUpStudent(body) { apiResponse, errorCode, errorBody ->
                                if (apiResponse != null) {
                                    dialogTitle.value="En hora buena!"
                                    errorMessageModel.value = "Tu registro se completo con exito"
                                    navigationToSignIn()
                                    println("Respuesta exitosa: $apiResponse")
                                } else {
                                    dialogTitle.value="Espera!"
                                    errorMessageModel.value = errorBody
                                    println("Error: Código de estado: $errorCode, Cuerpo del error: $errorBody")
                                }
                            }
                        }) {
                        Text("Registrarme")
                    }

                    Text(
                        text = "Volver",
                        modifier = Modifier.clickable {
                            pressOnBack()
                        },
                        style = TextStyle(
                            textDecoration = TextDecoration.Underline,
                            color = MaterialTheme.colorScheme.primary
                        )
                    )
                    MessageError(errorMessageModel, dialogTitle.value)
                }

            }
        }
    }


}

