package pe.edu.upc.flexistudentmobile.ui.screens.signin

import androidx.compose.foundation.Image
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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
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
import pe.edu.upc.flexistudentmobile.R
import pe.edu.upc.flexistudentmobile.factories.repositories.StudentRepositoryFactory
import pe.edu.upc.flexistudentmobile.model.data.RequestSignInStudentBody
import pe.edu.upc.flexistudentmobile.model.data.RequestSignInStudentState
import pe.edu.upc.flexistudentmobile.shared.MessageError


@Composable
fun SignInScreen(errorMessageModel: MutableState<String?>, sinUpFirstStep:()->Unit, signInSuccessful:()->Unit) {

    val email = remember{
        mutableStateOf("")
    }

    val password = remember{
        mutableStateOf("")
    }

    val requestSignInStudentState = RequestSignInStudentState()

    Scaffold { paddingValues->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .background(color = MaterialTheme.colorScheme.primary),
            contentAlignment = Alignment.Center
        ){

            Card (modifier = Modifier
                .fillMaxWidth(0.85f)
                .fillMaxHeight(0.6f),
                colors = CardDefaults.cardColors(
                    containerColor = Color.White,
                ),
                shape = RoundedCornerShape(20.dp)
            ) {

                Column(
                    modifier= Modifier
                        .fillMaxSize()
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {

                    Text(
                        modifier=Modifier.padding(16.dp),
                        text = "FlexiDorm!",
                        style = TextStyle(
                            fontWeight = FontWeight.Bold,
                            fontSize = 30.sp,
                            textAlign = TextAlign.Center,
                            color = MaterialTheme.colorScheme.primary
                        )
                    )

                    Text(
                        modifier=Modifier.padding(14.dp),
                        text = "Hola Estudiante",
                        style = TextStyle(color = MaterialTheme.colorScheme.primary)
                    )


                    Column {
                        Text(
                            modifier=Modifier.padding(5.dp),
                            text = "Correo electronico",
                            style = TextStyle(color = MaterialTheme.colorScheme.primary)
                        )

                        OutlinedTextField(
                            value = email.value,
                            onValueChange = {
                                email.value = it
                                requestSignInStudentState.email = it
                            },
                            placeholder = {
                                Text("Correo electronico",
                                style = TextStyle(color = MaterialTheme.colorScheme.primary))
                            },

                            textStyle = TextStyle(
                                color = MaterialTheme.colorScheme.primary,
                                fontSize = 15.sp
                            ),
                            shape = RoundedCornerShape(15.dp),
                            singleLine = true,
                            colors= OutlinedTextFieldDefaults.colors(
                                unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                            )
                        )

                        Spacer(modifier = Modifier.height(10.dp))

                        Text(
                            modifier=Modifier.padding(5.dp),
                            text = "Contraseña",
                            style = TextStyle(color = MaterialTheme.colorScheme.primary)
                        )
                        OutlinedTextField(
                            value = password.value,
                            onValueChange = {
                                password.value = it
                                requestSignInStudentState.password = it
                            },
                            placeholder = {
                                Text("Ingresa tu contraseña",
                                    style = TextStyle(
                                        color = MaterialTheme.colorScheme.primary
                                    )
                                )
                            },
                            textStyle = TextStyle(
                                color = MaterialTheme.colorScheme.primary,
                                fontSize = 15.sp
                            ),
                            shape = RoundedCornerShape(15.dp),
                            singleLine = true,
                            colors= OutlinedTextFieldDefaults.colors(
                                unfocusedBorderColor = MaterialTheme.colorScheme.primary,
                            )
                        )
                    }

                    Spacer(modifier = Modifier.height(30.dp))

                    Button(
                        colors= ButtonDefaults.buttonColors(
                            contentColor = Color.White,
                            containerColor = MaterialTheme.colorScheme.primary
                        ),

                        onClick = {

                            if(
                                email.value.isEmpty() ||
                                password.value.isEmpty()
                            ){
                                errorMessageModel.value= "Los campos no pueden estar vacios"
                                return@Button
                            }

                            val body = RequestSignInStudentBody (
                                email = email.value,
                                password = password.value
                            )

                            val studentRepository= StudentRepositoryFactory.getStudentRepository("")


                            studentRepository.signInStudent(body){apiResponse, errorCode, errorBody ->
                                if (apiResponse != null) {
                                    var studentEntity = apiResponse.data
                                    studentRepository.deleteAllStudentDataLocal()
                                } else {
                                    errorMessageModel.value = errorBody
                                    println("Error: Código de estado: $errorCode, Cuerpo del error: $errorBody")
                                }
                            }
                        }

                    ) {

                        Text(text = "Iniciar sesion")
                    }

                    Row {
                        Text(text = "¿No tienes cuenta?",style=TextStyle(color = MaterialTheme.colorScheme.primary))
                        Text(
                            text = "Registrate",
                            modifier = Modifier.padding(horizontal = 3.dp).clickable {
                                sinUpFirstStep()
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