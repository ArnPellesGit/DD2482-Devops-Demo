import {useCallback, useState} from "react";

// A lil' easter egg :)
export function useCount() {
    const [state, setState] = useState(35)

    const inc = useCallback(() => setState(p => p +1), [state])
    const dec = useCallback(() => setState(p => p-1),[state])

    return {
        inc, dec, count: state === 42 ? "DevOps" : state
    }

}