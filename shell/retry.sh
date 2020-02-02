n=0
until [ $n -ge 5 ]
do
   fail_command && break
   n=$[$n+1]
   sleep 1
done


```
$ sh /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh
/Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh: line 4: fail_command: command not found
/Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh: line 4: fail_command: command not found
/Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh: line 4: fail_command: command not found
/Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh: line 4: fail_command: command not found
/Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/shell/retry.sh: line 4: fail_command: command not found
```
