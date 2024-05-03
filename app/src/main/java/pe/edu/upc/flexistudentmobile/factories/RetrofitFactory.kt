package pe.edu.upc.flexistudentmobile.factories

import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import pe.edu.upc.flexistudentmobile.core_network.ApiClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitFactory private constructor() {
    companion object {
        private var retrofit: Retrofit? = null
        fun getRetrofit(token:String): Retrofit {
            println( "Token: $token")
            if (retrofit == null) {
                val client = OkHttpClient.Builder()
                    .addInterceptor(AuthInterceptor(token))
                    .build()


                retrofit = Retrofit.Builder()
                    .baseUrl(ApiClient.BASE_URL)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build()
            }
            return retrofit as Retrofit
        }
    }
}

class AuthInterceptor(private val token: String) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request().newBuilder()
            .addHeader("Authorization", "Bearer $token")
            .build()
        return chain.proceed(request)
    }
}