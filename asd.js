function fromEvent(target, eventName) {

    // This function  (Publisher/Producer) runs when subscribe() is called
    const porduceFn = (observer) => {
  
      // Add the event handler to the target
      target.addEventListener(eventName, (e) => observer.next(e)  );
  
      return () => {
        // unsubscribe
        // Deattach the event handler from the target
        target.removeEventListener(eventName, handler);
      };
    }
  
    return new Observable(  porduceFn  );
  }
  
  
  
  
  const ESC_KEY = 27;
  const nameInput = document.getElementById('name') as HTMLInputElement;
  
  
  
  
  const myObserver = {
      next: (e: KeyboardEvent) => { if (e.keyCode === 27)  nameInput.value = ''; }
  }
  
  const subscription = fromEvent(nameInput, 'keydown')  // instance of Observable
  subscription.subscribe(myObserver);
  
  