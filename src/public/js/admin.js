$(document).ready(function(){
    $("#slide-up").on("click",function(){
        $("#add").slideUp("slow");
        $('#slide-down').show("fast")
      });
    $("#slide-down").on("click",function(){
        // const self = this
        $(this).hide("fast")
      $("#add").slideDown("slow",function () {

      });
    });

    $(".edit-js").on("click",function(){
        const name = $(this).closest('tr').find(".name-js").text()
        $('.admin-edit-modal .admin-name').text(name)
        $(".admin-edit-modal #name").val(name)
        $(".admin-edit-modal #number").val($(this).closest('tr').find(".number-js").text())
        $(".admin-edit-modal #access").val($(this).closest('tr').find(".access-js").data('access'))
        $(".admin-edit-modal #condition").val($(this).closest('tr').find(".condition-js").data('enable'))
        $('.admin-edit-modal .edit-admin').data('id',$(this).closest('tr').data('id'))
    })

    $('.add-admin').on('click',function () {
        const fullName = $('#add #name').val()
        const phoneNumber = $('#add #phone').val()
        const access = $('#add .access').val()
        const enable = $('#add .enable').val()

        showLoading()
        sendAjax('/dashboard/admin/add',{fullName,phoneNumber,access,enable},(res) => {
            showSuccess(res.message)
            setTimeout(() => {
                location.reload()
            },2000)
        })
    })

    $('.admin-edit-modal .edit-admin').on('click',function () {
        const fullName = $('.admin-edit-modal #name').val()
        const phoneNumber = $('.admin-edit-modal #number').val()
        const access = $('.admin-edit-modal #access').val()
        const enable = $('.admin-edit-modal #condition').val()
        const id =$(this).data('id')

        showLoading()
        sendAjax('/dashboard/admin/edit',{fullName,phoneNumber,access,enable,id},(res) => {
            showSuccess(res.message)
            setTimeout(() => {
                location.reload()
            },2000)
        })
    })

    $('.delete-admin').on('click',function () {
        const id = $(this).closest('tr').data('id')
        const name = $(this).closest('tr').find('.name-js').text()
        showWarning('اخطار حذف مشتری',`آیا برای حذف “${name}” مطمئن هستید؟`,'بله، حذف مشتری',() => {
            showLoading()
            sendAjax('/dashboard/admin/delete',{id},(res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })

    $('.see-admin-log').on('click',function () {
        const json = JSON.parse($(this).closest('.icon-table').find('.admin-logs').text())

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
});