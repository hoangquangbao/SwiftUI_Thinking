# Combine

#### _Example_
`let items: [Int] = Array(1..<11)`
##### CurrentValueSubject
- Replace a publisher variable with the CurrentValueSubject
- `let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")`
##### PassthroughSubject
- That works the exact same way as CurrentValueSubject except it don't hold stating value
- `let passThrounghPublisher = PassthroughSubject<String, Error>()`
##### Sequence Operation
###### **1. FIRST**
            .first()
            .first(where: <#T##(Int) -> Bool#>)
            .tryFirst(where: <#T##(Publishers.First<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
###### **2. LAST**
            .last()
            .last(where: <#T##(Int) -> Bool#>)
            .tryLast(where: <#T##(Publishers.Last<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
###### **3. DROP**
            .dropFirst()
            .drop(while: <#T##(Int) -> Bool#>)
            .tryDrop(while: <#T##(Publishers.Drop<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
            .drop(untilOutputFrom: <#T##Publisher#>)
###### **4. PREFIT**
            .prefix(<#T##maxLength: Int##Int#>)
            .prefix(while: <#T##(Int) -> Bool#>)
            .tryPrefix(while: <#T##(Publishers.Output<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
            .prefix(untilOutputFrom: <#T##Publisher#>)
###### **5. OUTPUT**
            .output(at: <#T##Int#>)
            .output(in: <#T##RangeExpression#>)




