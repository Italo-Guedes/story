import * as React from 'react';
import { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import clsx from 'clsx';
import { refType } from '@material-ui/utils';
import { 
  Input,
  FilledInput,
  OutlinedInput,
  InputLabel,
  FormControl,
  FormHelperText,
  InputAdornment,
  IconButton,
  Avatar
} from '@material-ui/core';
import PhotoCameraIcon from '@material-ui/icons/PhotoCamera';
import CloudUploadIcon from '@material-ui/icons/CloudUpload';
import CancelIcon from '@material-ui/icons/Cancel';


import { withStyles } from '@material-ui/core/styles';

const variantComponent = {
  standard: Input,
  filled: FilledInput,
  outlined: OutlinedInput,
};

export const styles = {
  /* Styles applied to the root element. */
  root: {},
};

/**
 * The `FileField` is a wraper for file upload with an optional preview.
 *
 * ## Advanced Configuration
 *
 * It's important to understand that the file field is a simple abstraction
 * on top of the following components:
 *
 * - [FormControl](/api/form-control/)
 * - [InputLabel](/api/input-label/)
 * - [FilledInput](/api/filled-input/)
 * - [OutlinedInput](/api/outlined-input/)
 * - [Input](/api/input/)
 * - [FormHelperText](/api/form-helper-text/)
 *
 * If you wish to alter the props applied to the `input` element, you can do so as follows:
 *
 * ```jsx
 * const inputProps = {
 *   step: 300,
 * };
 *
 * return <FileField id="time" type="time" inputProps={inputProps} />;
 * ```
 *
 * For advanced cases, please look at the source of FileField by clicking on the
 * "Edit this page" button above. Consider either:
 *
 * - using the upper case props for passing values directly to the components
 * - using the underlying components directly as shown in the demos
 */
const FileField = React.forwardRef(function FileField(props, ref) {
  const {
    accept,
    showPreview = true,
    showUploadAdornment = true,
    autoComplete,
    autoFocus = false,
    children,
    classes,
    className,
    color = 'primary',
    defaultValue,
    disabled = false,
    error = false,
    FormHelperTextProps,
    fullWidth = false,
    helperText,
    hiddenLabel,
    id,
    InputLabelProps = { shrink: true },
    inputProps,
    InputProps,
    inputRef,
    label,
    multiline = false,
    name,
    onBlur,
    onChange,
    onFocus,
    placeholder,
    required = false,
    rows,
    rowsMax,
    select = false,
    SelectProps,
    value,
    variant = 'standard',
    ...other
  } = props;

  const [preview, setPreview] = useState(null);
  const [localValue, setLocalValue] = useState(null);
  let fileInput = React.createRef();

  const InputMore = {};

  function localHandleChange(e) {
    setLocalValue(e.target.files[0]);
    onChange && onChange(e);
  }

  function handleUploadClick(e) {
    if (localValue) {
      fileInput.current.value = '';
      fileInput.current.files = [];
      setLocalValue('');
      setPreview(undefined);
      e.preventDefault();
      if (onChange) {
        onChange({
          target: {
            value: '',
            files: [false]
          }
        });
      }
    }
  }

  useEffect(loadPicturePreview, [localValue]);

  function loadPicturePreview() {
    if (localValue) {
      var reader = new FileReader();
      reader.onload = (e) => {
        setPreview(e.target.result);
      };
      reader.readAsDataURL(localValue);
    }
  }

  if (variant === 'outlined') {
    if (InputLabelProps && typeof InputLabelProps.shrink !== 'undefined') {
      InputMore.notched = InputLabelProps.shrink;
    }
    if (label) {
      InputMore.label = (
        <React.Fragment>
          {label}
          {required && '\u00a0*'}
        </React.Fragment>
      );
    }
  }
  if (select) {
    // unset defaults from textbox inputs
    if (!SelectProps || !SelectProps.native) {
      InputMore.id = undefined;
    }
    InputMore['aria-describedby'] = undefined;
  }

  const helperTextId = helperText && id ? `${id}-helper-text` : undefined;
  const inputLabelId = label && id ? `${id}-label` : undefined;
  const InputComponent = variantComponent[variant];
  const InputElement = (
    <InputComponent
      aria-describedby={helperTextId}
      autoComplete={autoComplete}
      autoFocus={autoFocus}
      defaultValue={defaultValue}
      fullWidth={fullWidth}
      name={name}
      type='file'
      ref={fileInput}
      value={value}
      id={id}
      inputRef={inputRef}
      onBlur={onBlur}
      onChange={localHandleChange}
      onFocus={onFocus}
      placeholder={placeholder}
      inputProps={inputProps}
      placeholder='&nbsp;'
      {...InputMore}
      {...InputProps}
      startAdornment={showPreview && 
        <InputAdornment position="start">
          <label htmlFor={name}>
            <IconButton color={color} aria-label={label} component="span">
              <Avatar src={preview}>
                {preview ? '' : <PhotoCameraIcon />}
              </Avatar>
            </IconButton>
          </label>
        </InputAdornment>
      }
      endAdornment={showUploadAdornment &&
        <InputAdornment position="end">
          <label htmlFor={name}>
            <IconButton color={color} aria-label={label} component="span" onClick={handleUploadClick}>
              {
                localValue ?
                <CancelIcon /> :
                <CloudUploadIcon />
              }
            </IconButton>
          </label>
        </InputAdornment>
      }
    />
  );

  return (
    <FormControl
      className={clsx(classes.root, className)}
      disabled={disabled}
      error={error}
      fullWidth={fullWidth}
      hiddenLabel={hiddenLabel}
      ref={ref}
      required={required}
      color={color}
      variant={variant}
      {...other}
    >
      {label && (
        <InputLabel htmlFor={id} id={inputLabelId} {...InputLabelProps}>
          {label}
        </InputLabel>
      )}

      {InputElement}

      {helperText && (
        <FormHelperText id={helperTextId} {...FormHelperTextProps}>
          {helperText}
        </FormHelperText>
      )}
    </FormControl>
  );
});

FileField.propTypes = {
  // ----------------------------- Warning --------------------------------
  // | These PropTypes are generated from the TypeScript type definitions |
  // |     To update them edit the d.ts file and run "yarn proptypes"     |
  // ----------------------------------------------------------------------
  /**
   * Accept attr for input field
   */
  accept: PropTypes.bool,
  /**
   * Show image preview in startAdornment
   */
  showPreview: PropTypes.bool,
  /**
   * Show upload button in endAdornment
   */
  uploadAdornment: PropTypes.bool,
  /**
   * This prop helps users to fill forms faster, especially on mobile devices.
   * The name can be confusing, as it's more like an autofill.
   * You can learn more about it [following the specification](https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#autofill).
   */
  autoComplete: PropTypes.string,
  /**
   * If `true`, the `input` element will be focused during the first mount.
   */
  autoFocus: PropTypes.bool,
  /**
   * @ignore
   */
  children: PropTypes.node,
  /**
   * Override or extend the styles applied to the component.
   * See [CSS API](#css) below for more details.
   */
  classes: PropTypes.object,
  /**
   * @ignore
   */
  className: PropTypes.string,
  /**
   * The color of the component. It supports those theme colors that make sense for this component.
   */
  color: PropTypes.oneOf(['primary', 'secondary']),
  /**
   * The default value of the `input` element.
   */
  defaultValue: PropTypes.any,
  /**
   * If `true`, the `input` element will be disabled.
   */
  disabled: PropTypes.bool,
  /**
   * If `true`, the label will be displayed in an error state.
   */
  error: PropTypes.bool,
  /**
   * Props applied to the [`FormHelperText`](/api/form-helper-text/) element.
   */
  FormHelperTextProps: PropTypes.object,
  /**
   * If `true`, the input will take up the full width of its container.
   */
  fullWidth: PropTypes.bool,
  /**
   * The helper text content.
   */
  helperText: PropTypes.node,
  /**
   * @ignore
   */
  hiddenLabel: PropTypes.bool,
  /**
   * The id of the `input` element.
   * Use this prop to make `label` and `helperText` accessible for screen readers.
   */
  id: PropTypes.string,
  /**
   * Props applied to the [`InputLabel`](/api/input-label/) element.
   */
  InputLabelProps: PropTypes.object,
  /**
   * [Attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#Attributes) applied to the `input` element.
   */
  inputProps: PropTypes.object,
  /**
   * Props applied to the Input element.
   * It will be a [`FilledInput`](/api/filled-input/),
   * [`OutlinedInput`](/api/outlined-input/) or [`Input`](/api/input/)
   * component depending on the `variant` prop value.
   */
  InputProps: PropTypes.object,
  /**
   * Pass a ref to the `input` element.
   */
  inputRef: refType,
  /**
   * The label content.
   */
  label: PropTypes.node,
  /**
   * If `dense` or `normal`, will adjust vertical spacing of this and contained components.
   */
  margin: PropTypes.oneOf(['dense', 'none', 'normal']),
  /**
   * Name attribute of the `input` element.
   */
  name: PropTypes.string.isRequired,
  /**
   * @ignore
   */
  onBlur: PropTypes.func,
  /**
   * Callback fired when the value is changed.
   *
   * @param {object} event The event source of the callback.
   * You can pull out the new value by accessing `event.target.value` (string).
   */
  onChange: PropTypes.func,
  /**
   * @ignore
   */
  onFocus: PropTypes.func,
  /**
   * If `true`, the label is displayed as required and the `input` element` will be required.
   */
  required: PropTypes.bool,
  /**
   * Props applied to the [`Select`](/api/select/) element.
   */
  SelectProps: PropTypes.object,
  /**
   * The size of the text field.
   */
  size: PropTypes.oneOf(['medium', 'small']),
  /**
   * The value of the `input` element, required for a controlled component.
   */
  value: PropTypes.any,
  /**
   * The variant to use.
   */
  variant: PropTypes.oneOf(['filled', 'outlined', 'standard']),
};

export default withStyles(styles, { name: 'MuiFileField' })(FileField);