$(document).ready(function(){
    $(this).scrollTop(0);
    $('.right').addClass("slideRight");
    $('.left').addClass("slideLeft");
    $('.down').addClass("slideDown");
    $('.not-visible').addClass("visible");

});

 $('#products').DataTable({
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#products').data('source'),

    "pagingType": "full_numbers",
    "pageLength": 500,
    "deferRender": true,
    "order": [ 0, 'asc' ],
    "iDisplayLength": 100,
    "scrollY": '425px',
    "scrollCollapse": true,
    "responsive": true,
    "fixedHeader": true,
    "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [ 3 ] }],
    "oLanguage": {
        "sProcessing": "<img src='../assets/load.gif' height='50' width='50'>"
    },
    "processing": true,
  });