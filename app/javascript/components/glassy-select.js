import React from 'react';
import Select from 'react-select';

var GlassySelect = React.createClass({
  displayName: 'GlassySelect',
  getInitialState () {
    return {
      multi: this.props.multi || false,
      options: this.props.options || [],
      value: this.props.value || null,
      placeholder: this.props.placeholder || 'Select...'
    };
  },
  handleSelectChange (value) {
    this.setState({ value });
  },
  propTypes: {
    label: React.PropTypes.string,
  },
  render: function() {
    return <Select multi={this.state.multi} name={this.props.name} value={this.state.value} placeholder={this.state.placeholder} options={this.state.options} onChange={this.handleSelectChange} />;
  }

});

module.exports.GlassySelect = GlassySelect;
