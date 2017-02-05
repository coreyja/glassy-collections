import { mountComponents } from 'react-rails-ujs';
import { GlassySelect } from './glassy-select';
import $ from 'jquery';

$(document).on('turbolinks:load', function() {
  mountComponents({
    GlassySelect,
  });
});
