# Rails Controller

```
class FileController < ApplicationController
  def create
    p params[:file].read
  end
end
```

```
curl -X POST http://localhost/file -F file=@/path/to/file
```
