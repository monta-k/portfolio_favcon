require 'rails_helper'

feature "Posts" do
  feature "Post test" do
    # 投稿するユーザー
    given!(:post_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # 別のユーザー
    given!(:another_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # すでにされている自分の投稿
    given!(:movie_post) { create(:movie_post, user_id: post_user.id, content: "映画の感想", trackId: "1243195844") }
    given!(:music_post) { create(:music_post, user_id: post_user.id, content: "曲の感想", artistId: "290156577", collectionId: "1291839477", trackId: "1291839839") }
    # すでに投稿されている他人の投稿
    given!(:another_movie_post) { create(:movie_post, user_id: another_user.id, content: "他人の映画感想", trackId: "672989722") }
    given!(:another_music_post) { create(:music_post, user_id: another_user.id, content: "他人の曲感想", artistId: "1103136313", collectionId: "991663272", trackId: "991663279") }

    scenario "music post create" do
      visit root_path
      # ログイン
      login(post_user.email, post_user.password)
      # 音楽ページへ移動できること
      click_link "Music"
      expect(page).to have_current_path(music_index_path)
      # 曲の投稿が表示されていること
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: music_post.content
      expect(page).to have_selector ".post-user-info h6", text: another_user.username
      expect(page).to have_selector ".content p", text: another_music_post.content
      # 映画の投稿が表示されていないこと
      expect(page).not_to have_selector ".content p", text: movie_post.content
      # アーティスト名で検索
      fill_in "投稿したい曲をアーティスト名で検索しよう", with: "punpee"
      click_button "検索"
      # 検索が正しく行われていること
      expect(page).to have_selector ".content-search-title", text: "検索結果：punpee"
      expect(page).to have_selector ".track a", text: "PUNPEE"
      # アーティストページへ移動
      click_link "PUNPEE"
      # 正しいアーティストページへ遷移すること
      expect(page).to have_selector ".content-search-title", text: "PUNPEE"
      expect(page).to have_selector ".track a", text: "MODERN TIMES"
      # アーティストに関する投稿が表示されていること
      expect(page).to have_selector ".posts-count", text: "PUNPEEの投稿一覧"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: music_post.content
      # アーティストと関係のない投稿が表示されていないこと
      expect(page).not_to have_selector ".post-user-info h6", text: another_user.username
      expect(page).not_to have_selector ".content p", text: another_music_post.content
      # アルバムページへ移動
      click_link "MODERN TIMES"
      # 正しいアルバムページへ遷移すること
      expect(page).to have_selector ".content-search-title", text: "MODERN TIMES"
      expect(page).to have_selector ".track a", text: "Happy Meal"
      # アルバムに関する投稿が表示されていること
      expect(page).to have_selector ".posts-count", text: "MODERN TIMESの投稿一覧"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: music_post.content
      # アルバムとは関係のない投稿が表示されていないこと
      expect(page).not_to have_selector ".post-user-info h6", text: another_user.username
      expect(page).not_to have_selector ".content p", text: another_music_post.content
      # 感想投稿ページに移動
      click_link "タイムマシーンにのって"
      # 正しい曲ページに移動
      expect(page).to have_selector ".track-title h2", text: "タイムマシーンにのって/PUNPEE"
      # 曲に関する投稿が表示されていること
      expect(page).to have_selector ".posts-count", text: "タイムマシーンにのってに関する投稿： 1件"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: music_post.content
      # 曲とは関係のない投稿が表示されていないこと
      expect(page).not_to have_selector ".post-user-info h6", text: another_user.username
      expect(page).not_to have_selector ".content p", text: another_music_post.content
      # 感想を投稿が成功すること
      fill_in "投稿文", with: "最高"
      expect { click_button "投稿する" }.to change(Post, :count).by(1)
      expect(page).to have_selector ".posts-count", text: "タイムマシーンにのってに関する投稿： 2件"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: "最高"
    end

    scenario "movie post create" do
      visit root_path
      # ログイン
      login(post_user.email, post_user.password)
      # 映画ページへ移動できること
      click_link "Movie"
      expect(page).to have_current_path(movie_index_path)
      # 映画の投稿が表示されていること
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: movie_post.content
      expect(page).to have_selector ".post-user-info h6", text: another_user.username
      expect(page).to have_selector ".content p", text: another_movie_post.content
      # 曲の投稿が表示されていないこと
      expect(page).not_to have_selector ".content p", text: music_post.content
      # 映画タイトルで検索
      fill_in "投稿したい映画をタイトルで検索しよう", with: "スパイダーマン"
      click_button "検索"
      # 検索が正しく行われていること
      expect(page).to have_selector ".content-search-title", text: "検索結果：スパイダーマン"
      expect(page).to have_selector ".track a", text: "アメイジング・スパイダーマン™ (字幕/吹替)"
      expect(page).to have_selector ".track a", text: "スパイダーマン：ホームカミング (字幕/吹替)"
      # 感想投稿ページに移動
      click_link "スパイダーマン：ホームカミング (字幕/吹替)"
      # 正しい映画ページに移動
      expect(page).to have_selector ".track-title h2", text: "スパイダーマン：ホームカミング (字幕/吹替)"
      # 映画に関する投稿が表示されていること
      expect(page).to have_selector ".posts-count", text: "スパイダーマン：ホームカミング (字幕/吹替)に関する投稿： 1件"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: movie_post.content
      # 映画と関係のない投稿が表示されていないこと
      expect(page).not_to have_selector ".post-user-info h6", text: another_user.username
      expect(page).not_to have_selector ".content p", text: another_movie_post.content
      # 感想を投稿が成功すること
      fill_in "投稿文", with: "スパイディー"
      expect { click_button "投稿する" }.to change(Post, :count).by(1)
      expect(page).to have_selector ".posts-count", text: "スパイダーマン：ホームカミング (字幕/吹替)に関する投稿： 2件"
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: "スパイディー"
    end

    scenario "post destroy" do
      visit root_path
      # ログイン
      login(post_user.email, post_user.password)
      # 音楽ページへ移動できること
      click_link "Music"
      expect(page).to have_current_path(music_index_path)
      # 曲の投稿が表示されていること
      expect(page).to have_selector ".post-user-info h6", text: post_user.username
      expect(page).to have_selector ".content p", text: music_post.content
      expect(page).to have_selector ".post-user-info h6", text: another_user.username
      expect(page).to have_selector ".content p", text: another_music_post.content
      # 自分の投稿に投稿削除ボタンが表示されていること
      expect(all(".post-bottom")[1]).to have_link '投稿削除'
      # 他人の投稿に投稿削除ボタンが表示されていないこと
      expect(all(".post-bottom")[0]).not_to have_link '投稿削除'
      # 投稿削除が成功すること
      expect { click_link "投稿削除" }.to change(Post, :count).by(-1)
      expect(page).not_to have_selector ".post-user-info h6", text: post_user.username
      expect(page).not_to have_selector ".content p", text: music_post.content
    end
  end
end
