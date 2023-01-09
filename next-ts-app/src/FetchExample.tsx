import {useState, useEffect} from 'react'

const FetchExample = () => {
  const [posts, setPosts] = useState([])

  useEffect(() => {
      fetch('https://jsonplaceholder.typicode.com/posts', {method: 'GET'})
      .then(res => res.json())
      .then(data => {
          setPosts(data)
      })
  },[])

  return (
      <div>
          <ul>
              {
                  posts.map(post =>
                  <li key={post['id']}>{post['title']}</li>
                  )
              }
          </ul>

      </div>
  )
}

export default FetchExample;

