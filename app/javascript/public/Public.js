import React, { useEffect } from 'react';
import { 
  CssBaseline, 
  Box,
  Container
} from '@material-ui/core';
import { BrowserRouter as Router, Route } from 'react-router-dom'
import { createMuiTheme, ThemeProvider, makeStyles } from '@material-ui/core/styles';
import Copyright from '../components/Copyright.js'
import SignIn from './SignIn.js'
import SignUp from './SignUp.js'
import ResetPassword from './ResetPassword.js'
import RequestPasswordReset from './RequestPasswordReset.js'
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './styles/main.scss'

const signInTheme = createMuiTheme({
  props: {
    // Name of the component ⚛️
    MuiTextField: {
      // The default props to change
      variant: "outlined",
      margin: "normal",
      fullWidth: true,
    },
  },
});

const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(8),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

export default function Public(props) {
  const classes = useStyles();

  useEffect(() => {
    // Atualiza o titulo do documento usando a API do browser
    if (props.flash.notice) {
      toast.info(props.flash.notice);
    }
    if (props.flash.notice) {
      toast.warning(props.flash.alert);
    }
  }, []);

  return (
    <div>
      <ToastContainer autoClose={8000} />
      <Container component="main" maxWidth="xs">
        <CssBaseline />
        <ThemeProvider theme={signInTheme}>
          <div className={classes.paper}>
            <Router>
              <Route exact path={["/public", "/public/sign_in"]}>
                <SignIn />
              </Route>
              <Route exact path="/public/sign_up">
                <SignUp />
              </Route>
              <Route exact path="/public/reset_password">
                <ResetPassword />
              </Route>
              <Route exact path="/public/request_password_reset">
                <RequestPasswordReset />
              </Route>
            </Router>
          </div>
          <Box mt={8}>
            <Copyright />
          </Box>
        </ThemeProvider>
      </Container>
    </div>
  );
}