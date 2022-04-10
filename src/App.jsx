import './App.css'
import {StyledContainer} from "./Components/ElementsForComponents";
import {useCount} from "./hooks/use-count";

function App() {

    const {inc, dec, count} = useCount()

  return (
    <div className="App">
      <header className="App-header">
          <StyledContainer>
              <button onClick={inc}>+</button>
              <p>{count}</p>
              <button onClick={dec}>-</button>
          </StyledContainer>

      </header>
    </div>
  )
}

export default App
