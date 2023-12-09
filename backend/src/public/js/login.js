$(() => {
    $('.login').on('submit',function (e) {
        e.preventDefault();
        const phoneNumber = $('#inputEmail').val()

        showLoading()


        sendAjax('/auth/get-mobile',
            {phoneNumber:phoneNumber},
            (res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.replace('/auth/otp')
                },1500)
        })
    })
})