$(() => {
    $('.delete-device').on('click',function () {
        const id = $(this).data('serial')
        showWarning('اخطار حذف دستگاه',`آیا برای حذف "${id}"مطمئن هستید؟`,'بله، حذف دستگاه',() => {
            showLoading()
            sendAjax('/dashboard/devices/delete',{serialNumber:id},(res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })

    $('.kick-device').on('click',function () {
        const id = $(this).data('serial')
        showWarning('اخطار قطع ارتباط دستگاه',`آیا برای قطع ارتباط دستگاه "${id}"مطمئن هستید؟`,'بله، قطع ارتباط دستگاه',() => {
            showLoading()
            sendAjax('/dashboard/devices/kick',{serialNumber:id},(res) => {
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

        const dateLog = $('#datelog')
        const textLog = $('#textlog')

        dateLog.html('')
        textLog.html('')

        if(json.length ==0) {
            $('.no-content-log').css({display:'block'})
            $('#exampleModallog .modal-body').css({'flex-direction':'column'})
            $('#exampleModallog .right-log').css({display:'none'})
            $('#exampleModallog .left-log').css({display:'none'})
        }else {
            $('#exampleModallog .modal-body').css({'flex-direction':'row'})
            $('#exampleModallog .right-log').css({display:'block'})
            $('#exampleModallog .left-log').css({display:'block'})
            $('.no-content-log').css({display:'none'})
            const dates = []
            const messages = []
            for (const d of json) {
                console.log(d)
                messages.push(d.message)
                dates.push(d.date)
            }

            for(let i=0;i<messages.length;i++) {
                console.log(dates[i])
                const d = dates[i].split(' ')
                const year = d[0]
                const hour = d[1]
                dateLog.append($('<li></li>').addClass('date').html(`<span>${year}</span> - <span>${hour}</span>`))
                textLog.append($('<li></li>').addClass('text').html(messages[i]))
            }
        }
    })
})