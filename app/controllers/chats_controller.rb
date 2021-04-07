class ChatsController < ApplicationController
  def show
    #BさんのUser情報を取得
    @user = User.find(params[:id])
    #user_roomsテーブルのuser_idがAさんのレコード（room_id）を配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)
    #user_idがBさん(@user)で、room_idがAさんが属するroom_id（配列）となるuser_roomsテーブルのレコードを取得して、user_roomsに格納。
    #これによって、すでにルームが存在していれば、AさんとBさんのroom_idがわかる
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    #user_roomsでルームを取得できなかった場合の処理
    if user_rooms.nil?
      #roomのidを採番
      @room = Room.new
      #裁判したidを使って、user_roomsのレコードを2人分（Aさん用、Ｂさん用）作る（＝AさんとBさんに共通のroom_idを作る）
      @room.save
      #Bさんの@user.idをuser_idとして、@room.idをroom_idとして、UserRoomモデルのがラムに保存（1レコード）
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      #Aさんのcurrent_user.idをuser_idとして、@room.idをroom_idとして、UserRoomモデルのがラムに保存（1レコード）
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      #user_roomsに紐づくroomsテーブルのレコード（roomsテーブルにはid(主キー)しかないので、受け取ってる値はroom.id)を@roomに格納
      #user_roomモデルとリレーションを持っているのはroomモデルなので、room_idでなく.roomにしないと、@room.chatsでchatsのレコードを取得できない
      @room = user_rooms.room
    end

    #@roomに紐づくchatsテーブルのレコードを@chatsに格納
    @chats = @room.chats
    #form_withでチャットを送信する際に必要な空のインスタンス
    #ここで@room.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない。結果的に、どのルームにチャットを投稿すればいいのかわからなくなる。
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end