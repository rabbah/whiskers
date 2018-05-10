function main (args) {
  if (args.name === undefined) {
    return { salutacions: "Benvinguts a OpenWhisk!" };
  } else {
    return { salutacions: `Benvinguts a ${args.name}` };
  }
}
