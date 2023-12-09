$(() => {
    $('.delete-device').on('click',function () {
        const id = $(this).data('serial')
        showWarning('اخطار حذف دستگاه',`آیا برای حذف "${id}"مطمئن هستید؟`,'بله',() => {
            showLoading()
            sendAjax('/devices/delete',{serialNumber:id},(res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })

    $('.kick-device').on('click',function () {
        const id = $(this).data('serial')
        showWarning('اخطار قطع ارتباط دستگاه',`آیا برای قطع ارتباط دستگاه "${id}"مطمئن هستید؟`,'بله',() => {
            showLoading()
            sendAjax('/devices/kick',{serialNumber:id},(res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })

    $('.see-device-log').on('click',function () {
        const json = JSON.parse($(this).closest('.icon-table').find('.device-logs').text())

        const name = $(this).closest('tr').find('.name-js').text()
        $('.admin-name-log').text(name)


        if(json.length ==0) {
            $('.notempty-modal-log').css({display:'none'})
            $('.empty-modal-log').attr('style',"display:flex !important")
        }else {
            $('.notempty-modal-log').css({display:'block'})
            $('.empty-modal-log').css({display:'none'})
            $('.list-of-logs').html('')
            const dates = []
            const messages = []
            for (const d of json) {

                messages.push(d.message)
                dates.push(d.date)
            }

            for(let i=0;i<messages.length;i++) {

                const d = dates[i].split(' ')
                const year = d[0]
                const hour = d[1]
                let logTemplate = $('#log-template').html()
                logTemplate = logTemplate.replace('{{hour}}',hour)
                logTemplate = logTemplate.replace('{{date}}',year)
                logTemplate = logTemplate.replace('{{text}}',messages[i])
                $('.list-of-logs').append(logTemplate)
            }
        }
    })
})