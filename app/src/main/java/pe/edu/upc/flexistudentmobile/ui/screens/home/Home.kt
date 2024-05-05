package pe.edu.upc.flexistudentmobile.ui.screens.home

import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import pe.edu.upc.flexistudentmobile.animations.SplashScreen1
import pe.edu.upc.flexistudentmobile.animations.SplashScreen2
import pe.edu.upc.flexistudentmobile.model.data.RequestReservationState
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentState
import pe.edu.upc.flexistudentmobile.model.data.Room
import pe.edu.upc.flexistudentmobile.ui.room.roomReserve.RoomReserve
import pe.edu.upc.flexistudentmobile.ui.room.roomReserve.RoomReserveDetails
import pe.edu.upc.flexistudentmobile.ui.room.roomlist.RoomList
import pe.edu.upc.flexistudentmobile.ui.screens.signin.SignInScreen
import pe.edu.upc.flexistudentmobile.ui.screens.signup.SignUpFirstScreen
import pe.edu.upc.flexistudentmobile.ui.screens.signup.SignUpSecondScreen

@Composable
fun Home(){
    val navController= rememberNavController()
    val requestSignUpStudent = RequestSignUpStudentState()
    val errorMessage = remember {
        mutableStateOf<String?>(null)
    }
    var selectedRoom = remember {
        mutableStateOf<Room?>(null)
    }

    NavHost(navController = navController, startDestination=Routes.SplashScreen1.route){

        composable(Routes.SplashScreen1.route){
            SplashScreen1(
                load = {
                    navController.navigate(Routes.SignIn.route)
                }
            )
        }

        composable(Routes.SplashScreen2.route){
            SplashScreen2(
                load = {
                    navController.navigate(Routes.RoomList.route)
                }
            )
        }

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
                },
                splashScreen2 = {
                    navController.navigate(Routes.SplashScreen2.route)
                }
            )
        }

        composable(Routes.RoomList.route){
            RoomList(
                roomReserve = {
                    selectedRoom.value = it
                    navController.navigate(Routes.RoomReserve.route)
                }
            )
        }

        composable(Routes.RoomReserve.route){
            selectedRoom.value?.let { t ->
                RoomReserve(room = t) {
                    navController.navigate(Routes.RoomReserveDetails.route)
                }
            }
        }

        composable(Routes.RoomReserveDetails.route){
            selectedRoom.value?.let { t ->
                RoomReserveDetails(room = t, RequestReservationState()) {
                    navController.navigate(Routes.RoomList.route)
                }
            }
        }
    }
}

sealed class Routes(val route:String){
    data object SignIn: Routes("SignIn")
    data object SignUpFirstStep: Routes("SignUpFirstStep")
    data object SignUpSecondStep: Routes("SignUpSecondStep")

    data object RoomList: Routes("RoomList")
    data object RoomReserve: Routes("RoomReserve")
    data object RoomReserveDetails: Routes("RoomReserveDetails")

    data object SplashScreen1: Routes("SplashScreen1")
    data object SplashScreen2: Routes("SplashScreen2")
}