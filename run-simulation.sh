#!/bin/bash
################################
# Carina Teixeira de Oliveira
# March 2016, Aracati, Brazil
################################

# checar todos os fluxos iniciaram, com max testes

clear

#-------------------------------------------------------------------------#
# PARAMETERS CONFIGURATION
#-------------------------------------------------------------------------#
#####NS3 INSTALLATION#####
 ### Set NS3 version and path installation
version=24.1
#path_project=/Users/carinaoliveira/Documents/SBRC2016/
#path_NS3=$path_project/ns-allinone-3.$version/ns-3.$version

path_project=/home/gustavo/Documentos/ProjetoMesh/ScriptMesh/NS-3
path_NS3=$path_project/ns-allinone-3.$version/ns-3.$version

#ls $path_NS3

rm -rf $path_NS3/mesh-*.* $path_NS3/mesh-.pcap $path_NS3/results.xml $path_NS3/logMesh*.txt #$path_NS3/checked*.dot

#echo "###########"
#ls $path_NS3

echo "################################################################################"

#####SIMULATION TIME#####
timeSimulationDiscovery=15
timeSimulation=100

#####CHANNEL AND INTERFACES#####
min_nb_interfaces=1
max_nb_interfaces=4
nb_channels=12 #nb channels 802.11b=3 - 802.11a=12

#####PACKET, FLOWS#####
packetSize=1024
nb_pps=100 #number of packets per second
nb_flows=1
#min_nb_flows=45
#max_nb_flows=45
#interval_nb_Flows=1

#####NS3 LOGS,REPORTS#####
export NS_LOG=
# export 'NS_LOG=*=level_all|prefix_func|prefix_time'
report=1 # [0-disable 1- enable] Generate "mesh-report.xml"
pcap=0 # [0-disable 1- enable] Generate "mp-.pcap"

#####SCENARIO#####
scenario=1
# 1 GRID
# 2 UNIFORM DISK: Allocate the positions uniformely (with constant density) randomly within a disc
# For each topology, a different set of parameters can be configured:
case $scenario in
    #GRID
    1)  axisX=10
	axisY=10
	step=100 #distance between nodes [default=100]
	nb_nodes=`expr $axisX \* $axisY`
	path_scenario=$path_NS3/mesh-traces-sbrc/grid-$step
	echo "Simulation Scenario: GRID with $nb_nodes nodes / step $step / PacketSize $packetSize"
    ;;
    #UNIFORM DISK
    2)  nb_nodes=20
	radius=300
	path_scenario=$path_NS3/TESTE #mesh-traces-MudandoPreq++/uniformDisk-$radius
	echo "Simulation Scenario: UNIFORM DISK with $nb_nodes nodes / radius $radius / PacketSize $packetSize"
    ;;
    *)  echo "ERROR: scenario $scenario does not exist. Choose between 1 (GRID) and 2 (UNIFORM DISK)."
	exit
    ;;
esac

#####TOPOLOGY#####
nb_sim_topologies=1  #total number of topologies
max_topologies_attempts=5

#####ROUNDS#####
nb_sim_rounds=30 #number of simulation rounds for each topology
max_rounds_attempts=1

echo "Simulate $nb_sim_topologies different topologies, each topology $nb_sim_rounds times. Max topologies attempts is $max_topologies_attempts. Max rounds attempts is $max_rounds_attempts. $nb_flows flows. $nb_pps pps"



echo "################################################################################"

#-------------------------------------------------------------------------#
# CHECK PARAMETERS
#-------------------------------------------------------------------------#
#Interfaces
if [ $min_nb_interfaces -eq 0 ] #-eq (equal)
then
    echo "ALERT: min_nb_interfaces must be greater than 0 (min_nb_interfaces [$min_nb_interfaces] > 0])"
    exit
fi

if [ $max_nb_interfaces -lt $min_nb_interfaces ] #-lt (less than)
then
    echo "ALERT: max_nb_interfaces must be greater than or equal to min_nb_interfaces (max_nb_interfaces [$max_nb_interfaces] >= min_nb_interfaces [$min_nb_interfaces])"
    exit
fi

#Flows
#if [ $min_nb_flows -eq 0 ]
#then
#    echo "ALERT: min_nb_flows must be greater than 0 (min_nb_interfaces [$min_nb_flows] > 0])"
#    exit
#fi

#if [ $max_nb_flows -lt $min_nb_flows ]
#then
#    echo "ALERT: max_nb_flows must be greater than or equal to min_nb_flows (max_nb_flows [$max_nb_flows] >= min_nb_flows [$min_nb_flows])"
#    exit
#fi

if [ $nb_flows -ge $nb_nodes ] #-ge (greater than or equal)
then
    #Root does not initiate a flow
    echo "ALERT: nb_nodes must be greater than nb_flows (nb_nodes [$nb_nodes] > nbFlows [$nb_flows])"
    exit
fi

#Topology
if [ $nb_sim_topologies -eq 0 ] #-eq (equal)
then
    echo "ALERT: nb_sim_topologies must be greater than 0 (nb_sim_topologies [$nb_sim_topologies] > 0])"
    exit
fi

if [ $nb_sim_rounds -eq 0 ] #-eq (equal)
then
    echo "ALERT: nb_sim_rounds must be greater than 0 (nb_sim_rounds [$nb_sim_rounds] > 0])"
    exit
fi

if [ $max_topologies_attempts -eq 0 ] #-eq (equal)
then
    echo "ALERT: max_topologies_attempts must be greater than 0 (max_topologies_attempts [$max_topologies_attempts] > 0])"
    exit
fi

#-------------------------------------------------------------------------#
# RUN SIMULATIONS
#-------------------------------------------------------------------------#

#for current_interface in 2 4
for ((  current_interface = $min_nb_interfaces ;  current_interface <= $max_nb_interfaces;  current_interface++  ))
do
	nb_topologies_failed_attempts=0
	#nb_topologies_success=0
	nb_sim_topologies_experiments=$nb_sim_topologies
	nb_sim_topologies_connected=1

	path_traces=$path_scenario/ns-3.$version-time-$timeSimulation-nbNodes-$nb_nodes-intf-$current_interface-channels-$nb_channels-packetSize-$packetSize/$nb_flows-flows/$nb_pps-pps-dividedBetweenNbFlows

        #remove old traces
        #rm -rf $path_traces

        #AJEITAR
	for ((  current_topology = 1 ;  current_topology <= $nb_sim_topologies_experiments;  current_topology++  ))
	do


	  if [ $nb_topologies_failed_attempts -eq $max_topologies_attempts ]
	  then

	      echo "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
	      echo "ALERT(1)! Simulation stopped after $max_topologies_attempts topologies attempts. Better try another configuration."
	      echo "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"

	      echo "**Simulation stopped after $max_topologies_attempts topologies attempts**" >> logMeshTopologyConnectivity.txt 2>&1

	      mv logMeshTopologyConnectivity.txt $path_traces

	      #stop simulation
	      exit
	  fi


	  #-------------------------------------------------#
	  #CHECK IF TOPOLOGY IS CONNECTED
	  # 1st step - each node has at least one neighbor
	  # 2nd step - each node reaches all other nodes
	  #-------------------------------------------------#

 	  echo "################################################################################"
	  echo "Interface=$current_interface / Topology=$current_topology" / pps=$nb_pps / Flows=$nb_flows
	  echo "ID next topology connected: $nb_sim_topologies_connected"
 	  echo "################################################################################"


	  discovery=1 #(0) false (1) true

	  cd $path_NS3

	  case $scenario in
	    ### GRID ###
	    1) ./waf --run "scratch/mesh
	    --seed=$current_topology
	    --discovery=$discovery
	    --time=$timeSimulationDiscovery
	    --topology=$scenario
	    --x-size=$axisX
	    --y-size=$axisY
	    --nbNodes=$nb_nodes
	    --step=$step
	    --interfaces=$current_interface
	    --report=$report
	    --packetSize=$packetSize" > logMeshSimulationDiscovery.txt 2>&1
	    ;;
	    ### UNIFORM DISK ###
	    2) ./waf --run "scratch/mesh
   	    --seed=$current_topology
	    --discovery=$discovery
	    --time=$timeSimulationDiscovery
	    --topology=$scenario
	    --nbNodes=$nb_nodes
	    --radius=$radius
	    --interfaces=$current_interface
	    --report=$report
	    --packetSize=$packetSize" #> logMeshSimulationDiscovery.txt 2>&1
	    ;;
	  esac

        #--------------------------------------#
	# Register number of neighbors per node
	#--------------------------------------#

	#pwd
	#Create file with information about the number of neighbors per node
	#rm logMeshSimulationTopology.txt

	echo "################################################################################" >> logMeshSimulationTopology.txt 2>&1
	echo " Topology $current_topology - $current_interface interface(s)" >> logMeshSimulationTopology.txt 2>&1
	echo "################################################################################" >> logMeshSimulationTopology.txt 2>&1
	sum_neighbors_mean=0 #reset

	for ((  n = 0 ;  n < $nb_nodes;  n++  ))
	do
	  sum_nbNeighbors=`grep -c 'peerMeshPointAddress=' mesh-report-$n.xml` #sum number of lines file
	  echo "Node $n= $sum_nbNeighbors neighbors" >> logMeshSimulationTopology.txt 2>&1
	  sum_neighbors_mean=`expr $sum_neighbors_mean \+ $sum_nbNeighbors`
	done

	meanLinks=`echo "scale = 5 ; $sum_neighbors_mean / $nb_nodes" | bc`
	echo "meanLinks=$meanLinks" >> logMeshSimulationTopology.txt 2>&1
	meanNeighbors=`echo "scale = 5 ; $meanLinks / $current_interface" | bc`
	echo "meanNeighbors=$meanNeighbors" >> logMeshSimulationTopology.txt 2>&1

      #-------------------------------#
      # Check if topology is connected
      #-------------------------------#
      #echo "caminho path_traces=$path_traces"

      ./check.py

      if [ $? -eq 1 ]
      then

      	nb_topologies_failed_attempts=`expr $nb_topologies_failed_attempts + 1`
        nb_sim_topologies_experiments=`expr $nb_sim_topologies_experiments + 1`

	#//////////////////////////////
	#save failed topology traces
	echo "Topology $current_topology is NOT CONNECTED" >> logMeshTopologyConnectivity.txt 2>&1
	path_traces_topology=$path_traces/topology-$current_topology-NOT-CONNECTED
	#rm -rf $path_traces_topology
	mkdir -p $path_traces_topology/discovery/report
	mv logMeshSimulationDiscovery.txt  $path_traces_topology/discovery
	mv logMeshSimulationTopology.txt   $path_traces_topology/discovery
	mv mesh-report-*.xml   		    $path_traces_topology/discovery/report
#mv checked*.dot 	      	    $path_traces_topology/discovery
	#//////////////////////////////

	echo "Topology $current_topology is NOT connected. $nb_topologies_failed_attempts/$max_topologies_attempts failed topologies attempts / nb_sim_topologies_experiments=$nb_sim_topologies_experiments "

      else

	nb_rounds_failed_attempts=0
	discovery=0

      	#//////////////////////////////
	#save good topology traces
      	path_traces_topology=$path_traces/topology-$nb_sim_topologies_connected
	#rm -rf $path_traces_topology
	mkdir -p $path_traces_topology/discovery/report
	mv logMeshSimulationDiscovery.txt  $path_traces_topology/discovery/
	mv logMeshSimulationTopology.txt   $path_traces_topology/discovery/
	mv mesh-report-*.xml   		    $path_traces_topology/discovery/report
#	mv checked*.dot 	      	    $path_traces_topology/discovery
        #//////////////////////////////

      	echo "Topology $current_topology is CONNECTED. Check started flows..."

          #nb_flows=$min_nb_flows  #reset

	  #return_topology_loop=0

	  #while [ $nb_flows -le $max_nb_flows ]
	  #do

	      #Check nb attempts rounds
	      #if [ $return_topology_loop -eq 1 ]
	     # then
		#echo "Try another Topology"
		#break
	      #fi

	      #return_topology_loop=0  #reset

	      #echo "FLOW $nb_flows of $max_nb_flows"

	      #nb_sim_rounds_experiments=$nb_sim_rounds


	for ((  current_round = 1 ;  current_round <= $nb_sim_rounds;  current_round++))
	do

	      echo "-----------------------------------------------"
	      echo "ROUND $current_round of $nb_sim_rounds"

	      #set rood id randomly
	      root=$(($RANDOM%$nb_nodes))
	      #echo "Root is $root (O is the first node/ id NS3= $root+1)"
	      id_root=`expr $root + 1`
	      id_intf=`expr $id_root \* $current_interface - $current_interface + 1`
	      valor=$(echo "ibase=10;obase=16;$id_intf" | bc) #convert decimal to hexa
	      #echo "Root is node $id_root (address mac decimal=$id_intf hexa=$valor)"
	      #echo "Root ID NS3 = $id_root / Root MAC Address 1º interface = 00:00:00:00:00:$valor"

	      case $scenario in
		### GRID ###
		1) ./waf --run "scratch/mesh
		--seed=$current_topology
		--discovery=$discovery
		--time=$timeSimulation
		--topology=$scenario
		--x-size=$axisX
		--y-size=$axisY
		--nbNodes=$nb_nodes
		--step=$step
		--interfaces=$current_interface
		--root=00:00:00:00:00:$valor
		--idRoot=$root
		--ipRoot=10.1.1.$id_root
		--nbFlows=$nb_flows
#--pps=$nb_pps
        --packetSize=$packetSize
		--report=$report
		--pcap=$pcap" > logMeshSimulation.txt 2>&1
		;;
		### UNIFORM DISK ###
		2) ./waf --run "scratch/mesh
		--seed=$current_topology
		--discovery=$discovery
		--time=$timeSimulation
		--topology=$scenario
		--nbNodes=$nb_nodes
		--radius=$radius
		--interfaces=$current_interface
		--root=00:00:00:00:00:$valor
		--idRoot=$root
		--ipRoot=10.1.1.$id_root
		--nbFlows=$nb_flows
#--pps=$nb_pps
		--packetSize=$packetSize
		--report=$report
		--pcap=$pcap" #> logMeshSimulation.txt 2>&1
		;;
	    esac

	    #check flows have started
	    nb_not_started_flow=`grep -c 'Flow Not Started:' logMeshSimulation.txt`
	    echo "Not started flow:" $nb_not_started_flow


	    ##############################
	    #Save final simulation traces
	    path_traces_round=$path_traces_topology/round-$current_round
	    mkdir -p $path_traces_round/report
	    #rm -rf $path_traces_round/report/*
	    mv mesh-report-*.xml $path_traces_round/report/

	    if [ $pcap -eq 1 ]
	    then
	      mkdir -p $path_traces_round/pcap
	      rm -rf $path_traces_round/pcap/*
	      mv *.pcap $path_traces_round/pcap/
	    fi

	    mv logMeshSimulation.txt $path_traces_round/
	    mv results.xml $path_traces_round/.
	    mv mesh-final.txt $path_traces_round/.
	    #mv MeshMultiInterface.tr $path_traces/.

	    #mv checked*.dot $path_traces/
	    ##############################

	    if [ $nb_not_started_flow -eq 0 ]
	    then
		  #echo "All flows OK ($nb_not_started_flow)."
		  #echo "current_round=$current_round / nb_sim_rounds=$nb_sim_rounds"

		  if [ $current_round -eq $nb_sim_rounds ]
		  then
		    echo "-> Topology $current_topology CONNECTED with all flows initialized"
		    echo "Topology $current_topology CONNECTED -> Topology $nb_sim_topologies_connected" >> logMeshTopologyConnectivity.txt 2>&1
		    nb_sim_topologies_connected=`expr $nb_sim_topologies_connected + 1`
		  fi

	    else
		  nb_rounds_failed_attempts=`expr $nb_rounds_failed_attempts + 1`

		  if [ $nb_rounds_failed_attempts -eq $max_rounds_attempts ]
		  then

		      nb_sim_topologies_experiments=`expr $nb_sim_topologies_experiments + 1`
		      nb_topologies_failed_attempts=`expr $nb_topologies_failed_attempts + 1`

		      echo "Topology $current_topology CONNECTED, BUT PROBLEM WITH FLOWS" >> logMeshTopologyConnectivity.txt 2>&1

		      #change traces folder name
		      mv $path_traces_topology $path_traces/topology-$current_topology-PROBLEM-FLOWS

		      echo "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
		      echo "ALERT(3)! $nb_rounds_failed_attempts/$max_rounds_attempts rounds attempts. $nb_topologies_failed_attempts/$max_topologies_attempts topologies attempts. Better try another topology."
		      echo "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"

		      #skip topology
		      break

		  fi

		    echo "ALERT(4)! $nb_rounds_failed_attempts/$max_rounds_attempts rounds attempts. Let's try again this round..."
		    echo "nb_sim_topologies_experiments=$nb_sim_topologies_experiments nb_sim_topologies_connected=$nb_sim_topologies_connected"

		    #repeat round
		    current_round=`expr $current_round - 1`
		    #break

		  fi

	    done # for [current_round]

	    #nb_flows=`expr $nb_flows + $interval_nb_Flows`

	    #done # while [ nbFlows ]

    fi # if [ connected ]

    done #current_topology


    mv logMeshTopologyConnectivity.txt $path_traces

done # current_interface
