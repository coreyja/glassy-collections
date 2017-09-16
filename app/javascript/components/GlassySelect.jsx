var React = require("react");
var Select = require("react-select");
var createReactClass = require("create-react-class");

var GlassySelect = createReactClass({
  displayName: 'GlassySelect',
  getInitialState: function () {
    return {
      multi: this.props.multi || false,
      options: this.props.options || [],
      value: this.props.value || null,
      placeholder: this.props.placeholder || 'Select...'
    };
  },
  handleSelectChange: function (value) {
    this.setState({ value });
  },
  render: function () {
    return <Select multi={this.state.multi} name={this.props.name} value={this.state.value} placeholder={this.state.placeholder} options={this.state.options} onChange={this.handleSelectChange} />;
  }

});

module.exports = GlassySelect;
