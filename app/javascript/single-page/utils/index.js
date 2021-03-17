import classNameGenerator from './classNameGenerator'

export function classNames(styles) {
  function myClassNames(names) {
    let classes = names.split(' ').reduce((str, name) => {
      return str + `${styles[name]} `
    }, '')
    return classes.trim();
  }

  return myClassNames;
}
