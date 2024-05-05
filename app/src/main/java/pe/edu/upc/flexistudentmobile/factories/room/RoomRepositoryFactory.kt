package pe.edu.upc.flexistudentmobile.factories.room

import pe.edu.upc.flexistudentmobile.repositories.RoomRepository

class RoomRepositoryFactory {
    companion object {
        private var roomRepository: RoomRepository? = null
        fun getRoomRepositoryFactory(token:String): RoomRepository {
            if (roomRepository == null) {
                roomRepository = RoomRepository(
                    roomService = RoomServiceFactory.getRoomServiceFactory(token),
                    token
                )
            }
            return roomRepository as RoomRepository
        }
    }
}