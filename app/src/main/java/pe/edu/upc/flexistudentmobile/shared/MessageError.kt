package pe.edu.upc.flexistudentmobile.shared

import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState

@Composable
fun MessageError(errorMessageModel: MutableState<String?>, errorTitle:String){
    errorMessageModel.value?.let { message ->
        AlertDialog(
            onDismissRequest = { errorMessageModel.value = null },
            title = { Text(errorTitle) },
            text = { Text(message) },
            confirmButton = {
                Button(onClick = { errorMessageModel.value = null }) {
                    Text("Aceptar")
                }
            }
        )
    }
}