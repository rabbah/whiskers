function main (args) {
  if (args.name === undefined) {
    return { salutacions: "Benvinguts a Nimbella!" };
  } else {
    return { salutacions: `Benvinguts a ${args.name}` };
  }
}
