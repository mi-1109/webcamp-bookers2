class SearchController < ApplicationController

  # ===== params ["search"]で検索フォームに入力された値を受け取り、検索されたmodel/value/methodをそれぞれのインスタンス変数に代入 ======
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @method = params["search"]["method"]
    @search_data = search_for(@model, @value, @method) # search_forの引数にインスタンス変数を渡すと、@search_dataに最終的な検索結果が入る

  end

  private

  def search_for(model, value, method)
    #選択したモデルがuserの場合
    if model == 'user'
      #選択した検索方法が完全一致のとき
      if method == 'exact_match'
        User.where(name: value)
      #選択した検索方法が部分一致のとき
      elsif method == 'partial_match'
        User.where('name LIKE ?', "%#{value}%")
      #選択した検索方法が前方一致のとき
      elsif method == 'forward_match'
        User.where('name LIKE?', "#{value}%")
      elsif method == 'backward_match'
      #選択した検索方法が後方一致のとき
        User.where('name LIKE?', "%#{value}")
      end
    #選択したモデルがbookの場合
    elsif model == 'book'
      if method == 'exact_match'
        Book.where(title: value)
      #選択した検索方法が部分一致のとき
      elsif method == 'partial_match'
        Book.where('title LIKE ?', "%#{value}%")
      #選択した検索方法が前方一致のとき
      elsif method == 'forward_match'
        Book.where('title LIKE?', "#{value}%")
      elsif method == 'backward_match'
      #選択した検索方法が後方一致のとき
        Book.where('title LIKE?', "%#{value}")
      end
    end
  end

end
