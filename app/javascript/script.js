document.addEventListener('turbolinks:load', function() {
    const mypageBtnContainer = document.getElementById('mypageBtnContainer');
    const mypageDropdown = document.getElementById('mypageDropdown');
    const avatarContainer = document.getElementById('avatarContainer');  // アバター画像部分も追加

    if (mypageBtnContainer && mypageDropdown && avatarContainer) {  // 両方存在するか確認
        // クリックイベントをアバターにも適用
        avatarContainer.addEventListener('click', function() {
            // ドロップダウンが表示されていない場合は表示、表示されている場合は非表示にする
            if (mypageDropdown.style.display === 'block') {
                mypageDropdown.style.display = 'none';
            } else {
                mypageDropdown.style.display = 'block';
            }
        });
        
        // クリックイベントをユーザー名ボタンにも適用
        mypageBtnContainer.addEventListener('click', function() {
            if (mypageDropdown.style.display === 'block') {
                mypageDropdown.style.display = 'none';
            } else {
                mypageDropdown.style.display = 'block';
            }
        });
    }
});
