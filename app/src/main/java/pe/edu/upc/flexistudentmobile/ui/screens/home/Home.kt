package pe.edu.upc.flexistudentmobile.ui.screens.home

import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentState
import pe.edu.upc.flexistudentmobile.ui.room.roomlist.RoomList
import pe.edu.upc.flexistudentmobile.ui.screens.signin.SignInScreen
import pe.edu.upc.flexistudentmobile.ui.screens.signup.SignUpFirstScreen
import pe.edu.upc.flexistudentmobile.ui.screens.signup.SignUpSecondScreen

@Composable
fun Home(){
    val navController= rememberNavController()
    val requestSignUpStudent = RequestSignUpStudentState()
    val errorMessage = remember { mutableStateOf<String?>(null) }

    NavHost(navController = navController, startDestination=Routes.SignUpFirstStep.route){
        composable(Routes.SignUpFirstStep.route){
            SignUpFirstScreen(
                requestSignUpStudent,
                errorMessage,
                secontStep= {
                    navController.navigate(Routes.SignUpSecondStep.route) },
                signInStep = {
                    navController.navigate(Routes.SignIn.route)}
            )
        }

        composable(Routes.SignUpSecondStep.route){
            SignUpSecondScreen(
                requestSignUpStudent,
                errorMessage,
                pressOnBack={
                    navController.popBackStack() },
                navigationToSignIn={
                    navController.navigate(Routes.SignIn.route)
                }
            )
        }

        composable(Routes.SignIn.route){
            SignInScreen(
                errorMessage,
                sinUpFirstStep={
                    navController.navigate(Routes.SignUpFirstStep.route)
                },
                signInSuccessful={
                    navController.navigate(Routes.RoomList.route)
                }
            )
        }

        composable(Routes.RoomList.route){
            RoomList()
        }
    }
}

sealed class Routes(val route:String){
    data object SignIn: Routes("SignIn")
    data object SignUpFirstStep: Routes("SignUpFirstStep")
    data object SignUpSecondStep: Routes("SignUpSecondStep")

    data object RoomList: Routes("RoomList")
}