// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales
//= require_tree .


$(document).on("page:fetch", function()
{
    $('body').css('opacity','.5')
});
$(document).on("page:receive", function()
{
    $('body').css('opacity','1')
});
$(document).on('page:load', function()
{
    tabs.init()
    window['rangy'].initialized = false
});
var tabs = {
    init: function()
    {
        $('#tabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        })
    }
};

$(document).on('ready', function()
{
    tabs.init();
});
