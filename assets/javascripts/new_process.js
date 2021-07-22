$(function(){
    $("#criteria-table").on("click", "#delete-btn", function() {
        $(this).closest('tr').remove(); 
    });

    $('#select-all-chk').click(function() {
        var checkboxes = $('#requirement-table tbody input:checkbox ');
        $(checkboxes).each(
            function(){
                this.checked = $('#select-all-chk').prop('checked');
            }
        );
    });

    $('#requirement-table tbody input:checkbox').click(function() {
        var checkAll = $('#select-all-chk');
        if ($(checkAll).is(':checked') && !($(this).is(':checked')))
            { $(checkAll).removeAttr('checked'); }
    });
})

//Comentario para subir a github JE