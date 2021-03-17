export default function classNameGenerator(styles) {

  function myClassNames(names) {
    if (!names) return ''

    let classes = names.split(' ').reduce((str, name) => {
      return str + `${styles[name]} `
    }, '')
    return classes.trim();
  }

  return myClassNames;
}
