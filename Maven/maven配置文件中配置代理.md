可以参照下边的配置，在settings.xml文件中配置：

<proxies>
  <proxy>
      <id>myProxy</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>172.16.68.38</host>
      <port>808</port>
    </proxy>
  </proxies>
  
  最主要的就是配置host和port标签。
