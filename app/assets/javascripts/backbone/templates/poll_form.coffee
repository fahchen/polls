App.Templates.PollForm = _.template """
  <div class="poll">
    <img src="<%= cover %>">
    <input class="title" placeholder="输入标题" type="text" value="<%= title %>">
    <textarea class="description"><%= description %></textarea>
  </div>
"""
