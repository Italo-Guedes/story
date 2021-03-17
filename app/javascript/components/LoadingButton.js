import React, { useState } from 'react';
import PropTypes from 'prop-types';

import { 
  Button,
  CircularProgress
} from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  root: {
    margin: theme.spacing(1),
    position: 'relative',
  },
  buttonProgress: {
    color: 'white',
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -12,
    marginLeft: -12,
  },
}));

LoadingButton.defaultProps = {
  loading: false,
};

LoadingButton.propTypes = {
  loading: PropTypes.bool
};

export default function LoadingButton({ loading, ...props }) {
  const classes = useStyles();
  
  return (
    <div className={classes.root}>
      <Button disabled={loading || props.disabled} {...props}>
        {props.children}
      </Button>
      {loading && <CircularProgress size={24} className={classes.buttonProgress} />}
    </div>
  );
}
