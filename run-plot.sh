#!/bin/bash
#NS3

echo "################################################################################"
#-------------------------------------------------------------------------#
# PARAMETERS CONFIGURATION
#-------------------------------------------------------------------------#
#####NS3 INSTALLATION#####
 ### Set NS3 version and path installation
version=24.1
path_project=/home/gustavo/Documentos/ProjetoMesh/ScriptMesh
path_results=$path_project/scriptsResults/scriptsResults/flows-WD2016
path_NS3=$path_project/NS-3/ns-allinone-3.$version/ns-3.$version

#####SIMULATION TIME#####
timeSimulation=80

#####CHANNEL AND INTERFACES#####
min_nb_interfaces=1
max_nb_interfaces=4
nb_channels=12 #nb channels 802.11b=3 - 802.11a=12

#####PACKET, FLOWS#####
packetSize=1024
nb_pps=300 # number of packets per second
#nb_flows=6
#min_nb_flows=45
#max_nb_flows=45
#interval_nb_Flows=1

#####SCENARIO#####
scenario=1
# 1 GRID
# 2 UNIFORM DISK: Allocate the positions uniformely (with constant density) randomly within a disc
# For each topology, a different set of parameters can be configured:
case $scenario in
    #GRID
    1)  axisX=4
	axisY=4
	step=100 #distance between nodes [default=100]
	nb_nodes=`expr $axisX \* $axisY`
	path_scenario=$path_NS3/mesh-traces-sbrc/grid-$step
	echo "Simulation Scenario: GRID with $nb_nodes nodes / step $step / PacketSize $packetSize"
    ;;
    #UNIFORM DISK
    2)  nb_nodes=50
	radius=300

	#path_scenario=$path_project/NS-3/TRACES-rede_mesh/uniformDisk-$radius
	echo "Simulation Scenario: UNIFORM DISK with $nb_nodes nodes / radius $radius / PacketSize $packetSize"
    ;;
    *)  echo "ERROR: scenario $scenario does not exist. Choose between 1 (GRID) and 2 (UNIFORM DISK)."
	exit
    ;;
esac

#####TOPOLOGY#####

nb_sim_topologies=1 #total number of topologies

#####ROUNDS#####
nb_sim_rounds=1 #number of simulation rounds for each topology


mkdir -p $path_results/plot/pps-$nb_pps

cd $path_results
rm -r result_*
rm *-temp-*




##############################################################
##############################################################
##################### Original 802.11s  ######################
##############################################################
##############################################################

for ((  current_interface = $min_nb_interfaces ;  current_interface <= $max_nb_interfaces;  current_interface++  ))
 do

      rm $path_results/plot/pps-$nb_pps/*-interface-$current_interface-original80211s

      #echo "###### $current_interface INTERFACES ######"

for nb_flows in 6 #18 30
do

      #echo "#### $nb_flows FLOWS  ####"

      #for ((  c = $minChannel ;  c <= $maxChannel;  c++  ))
      #do

      cd $path_results

      rm TxPackets/TxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm RxPackets/RxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm AggregateThroughput/AggregateThroughput-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm LostPackets/LostPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm DeliveryRate/DeliveryRate-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm DelayMeanAverage/DelayMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm JitterMeanAverage/JitterMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm DropMacQueue/DropMacQueue-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm RxBytes/RxBytes-nbFlows-$nb_flows-original80211s
      #rm FramesSentTotal/FramesSentTotal-nbFlows-$nb_flows-original80211s
      #rm FramesSentData/FramesSentData-nbFlows-$nb_flows-original80211s
      #rm FramesSentMng/FramesSentMng-nbFlows-$nb_flows-original80211s
      #rm TimesForwarded/TimesForwarded-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm MeanTransmittedPacketSize/MeanTransmittedPacketSize-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm MeanTransmittedBitrate/MeanTransmittedBitrate-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm MeanHopCount/MeanHopCount-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm PacketLossRatio/PacketLossRatio-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm MeanReceivedPacketSize/MeanReceivedPacketSize-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm MeanReceivedBitrate/MeanReceivedBitrate-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm DroppedTtlL3/DroppedTtlL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm QueuedL3/QueuedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm DroppedL3/DroppedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #preq
      rm Preq-initiatedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm Preq-initiatedPreqProactive/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm Preq-retransmittedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm Preq-total/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #prep
      rm Prep-initiatedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm Prep-retransmittedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm Prep-total/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #perr
      rm Perr-initiatedPerr/Perr-initiatedPerr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm Perr-retransmittedPerr/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm Perr-total/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s

      rm RoutingControlPackets/RoutingControlPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm txPreqHWMP/tx*HWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm txPrepHWMP/tx*HWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      rm txPerrHWMP/tx*HWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm txMngtxDataHWMP/tx*HWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
      #rm PMP/*PMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s

      for ((  current_topology = 1 ;  current_topology <= $nb_sim_topologies;  current_topology++  ))
      do

	    echo "################################################################################"
	    echo "PPS = $nb_pps / Flows=$nb_flows / Interface=$current_interface / Topology=$current_topology"
	    echo "################################################################################"

	  #rounds for the same topology
	  for ((  current_round = 1 ;  current_round <= $nb_sim_rounds;  current_round++))
	  do

		echo "Round" $current_round

		cd $path_scenario/ns-3.$version-time-$timeSimulation-nbNodes-$nb_nodes-intf-$current_interface-channels-$nb_channels-packetSize-$packetSize/
      cd $nb_flows-flows/
        cd $nb_pps-pps-dividedBetweenNbFlows/
          cd topology-$current_topology/
            cd round-$current_round

        #sum
		grep 'TxPackets'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_TxPackets
		grep 'RxPackets'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_RxPackets
		grep 'Throughput'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_AggregateThroughput
		grep 'LostPackets'		logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_LostPackets
		grep 'DeliveyRate' 		logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_DeliveryRate
		grep 'DelayMean'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_DelayMean
		grep 'JitterMean'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_JitterMean
		#grep '>>DropPacketWifiMacQueue' 	logMeshSimulation.txt                      		     > $path_results/result_DropMacQueue
		#grep 'RxBytes'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_RxBytes
		#grep '>>SentFrame#'             logMeshSimulation.txt | cut -d: -f1 | cut -d'#' -f2 > $path_results/result_FramesSentTotal
		# 512+28+14=554
		#grep '>>SentFrame#554'          logMeshSimulation.txt | cut -d: -f1 | cut -d'#' -f2 > $path_results/result_FramesSentData
        	#grep 'TimesForwarded'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_TimesForwarded
	        #grep 'MeanTransmittedPacketSize'	logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_MeanTransmittedPacketSize
        	#grep 'MeanTransmittedBitrate'		logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_MeanTransmittedBitrate
	        #grep 'MeanHopCount'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_MeanHopCount
        	#grep 'PacketLossRatio'			logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_PacketLossRatio
	        #grep 'MeanReceivedPacketSize'		logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_MeanReceivedPacketSize
        	#grep 'MeanReceivedBitrate'		logMeshSimulation.txt | cut -d: -f2 | cut -d'%' -f1        > $path_results/result_MeanReceivedBitrate

		#remove past results
		rm report/result_HwmpProtocolMac
		rm report/result_tx*HWMP

		#one .xml file per node
		for ((  x = 0 ;  x < $nb_nodes;  x++  ))
		#for ((  x = 0 ;  x < 5;  x++  ))
		do
  		    #echo "xml node" $x
		    grep 'droppedTtl='                   report/mesh-report-$x.xml | cut -d= -f5 | cut -d'"' -f2 >> $path_results/result_DroppedTtlL3
		    grep 'totalQueued=' 		  report/mesh-report-$x.xml | cut -d= -f6 | cut -d'"' -f2 >> $path_results/result_QueuedL3
		    grep 'totalDropped='  	 	  report/mesh-report-$x.xml | cut -d= -f7 | cut -d'"' -f2 >> $path_results/result_DroppedL3
		    grep 'initiatedPreq='		  report/mesh-report-$x.xml | cut -d= -f8 | cut -d'"' -f2 >> $path_results/result_initiatedPreq
		    grep 'initiatedPreqProactive=' 	  report/mesh-report-$x.xml | cut -d= -f9 | cut -d'"' -f2 >> $path_results/result_initiatedPreqProactive
		    grep 'retransmittedPreq=' 	  	  report/mesh-report-$x.xml | cut -d= -f10 | cut -d'"' -f2 >> $path_results/result_retransmittedPreq
		    grep 'initiatedPrep=' 	          report/mesh-report-$x.xml | cut -d= -f11 | cut -d'"' -f2 >> $path_results/result_Prep
		    grep 'retransmittedPrep=' 	          report/mesh-report-$x.xml | cut -d= -f12 | cut -d'"' -f2 >> $path_results/result_retransmittedPrep
		    grep 'initiatedPerr='		  report/mesh-report-$x.xml | cut -d= -f13 | cut -d'"' -f2 >> $path_results/result_Perr
		    #grep 'retransmittedPerr='	          report/mesh-report-$x.xml | cut -d= -f14 | cut -d'"' -f2 >> $path_results/result_retransmittedPerr

		    sed -n -e '/<HwmpProtocolMac/,/HwmpProtocolMac>/ p' report/mesh-report-$x.xml >> report/result_HwmpProtocolMac
		    sed -n -e '/<PeerManagementProtocolMac/,/PeerManagementProtocolMac>/ p' report/mesh-report-$x.xml >> report/result_PeerManagementProtocolMac

		done

		#HWMP
		grep 'txPreq='      report/result_HwmpProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txPreqHWMP
		grep 'txPrep='      report/result_HwmpProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txPrepHWMP
		grep 'txPerr='      report/result_HwmpProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txPerrHWMP
		#grep 'txMgtHWMPBytes='  report/result_HwmpProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txMgtBytesHWMP
		#grep 'txDataBytes=' report/result_HwmpProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txDataBytesHWMP
		#PMP
	        #grep 'txOpen='      report/result_PeerManagementProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txOpenPMP
		#grep 'txConfirm='   report/result_PeerManagementProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txConfirmPMP
		#grep 'txClose='     report/result_PeerManagementProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txClosePMP
        	#grep 'txMgtBytes='  report/result_PeerManagementProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_txMgtBytesPMP
        	#grep 'dropped='     report/result_PeerManagementProtocolMac | cut -d= -f2 | cut -d'"' -f2 >> $path_results/result_droppedPMP


		#save
		cp $path_results/result_tx*HWMP report/.


		cd $path_results

		sum_TxPackets=`awk '{ s=s+$1 } END {print s}' result_TxPackets`
		sum_RxPackets=`awk '{ s=s+$1 } END {print s}' result_RxPackets`
		sum_AggregateThroughput=`awk '{ s=s+$1 } END {print s}' result_AggregateThroughput`
		sum_LostPackets=`awk '{ s=s+$1 } END {print s}' result_LostPackets`
		average_DeliveryRate=`awk '{ s += $1 } END {print s/NR}' result_DeliveryRate`
		average_DelayMean=`awk '{ s += $1 } END {print s/NR}' result_DelayMean`
	        average_JitterMean=`awk '{ s += $1 } END {print s/NR}' result_JitterMean`
        	#sum_TimesForwarded=`awk '{ s=s+$1 } END {print s}' result_TimesForwarded`
		#sum_RxBytes=`awk '{ s=s+$1 } END {print s}' result_RxBytes`
		#sum_FramesSentTotal=`awk '{ s=s+$1 } END {print s}' result2_FramesSentTotal`
		#sum_FramesSentData=`awk '{ s=s+$1 } END {print s}' result2_FramesSentData`
		#sum_FramesSentMng=`expr $sum_FramesSentTotal - $sum_FramesSentData`
	        #average_PacketLossRatio=`awk '{ s += $1 } END {print s/NR}' result_PacketLossRatio`

        	sum_DroppedTtlL3=`awk '{ s=s+$1 } END {print s}' result_DroppedTtlL3`
		sum_QueuedL3=`awk '{ s=s+$1 } END {print s}' result_QueuedL3`
		sum_DroppedL3=`awk '{ s=s+$1 } END {print s}' result_DroppedL3`

	        #preq
		sum_initiatedPreq=`awk '{ s=s+$1 } END {print s}' result_initiatedPreq`
		sum_initiatedPreqProactive=`awk '{ s=s+$1 } END {print s}' result_initiatedPreqProactive`
		sum_retransmittedPreq=`awk '{ s=s+$1 } END {print s}' result_retransmittedPreq`
		sum_PreqTotal=`expr $sum_initiatedPreq \+ $sum_initiatedPreqProactive \+ $sum_retransmittedPreq`
		#prep
		sum_initiatedPrep=`awk '{ s=s+$1 } END {print s}' result_Prep`
		sum_retransmittedPrep=`awk '{ s=s+$1 } END {print s}' result_retransmittedPrep`
		sum_PrepTotal=`expr $sum_initiatedPrep \+ $sum_retransmittedPrep`
        	#echo "**************************************sum_PrepTotal=" $sum_PrepTotal
		#perr
		sum_initiatedPerr=`awk '{ s=s+$1 } END {print s}' result_Perr`
		#sum_retransmittedPerr=`awk '{ s=s+$1 } END {print s}' result_retransmittedPerr`
	        #sum_PerrTotal=`awk '{ s=s+$1 } END {print s}' result_Perr` #`expr $sum_initiatedPerr \+ $sum_retransmittedPerr`
        	#echo "**************************************sum_PerrTotal=" $sum_PerrTotal

	        #totalControl
        	#sum_RoutingControlPackets=`expr $sum_PreqTotal \+ $sum_PrepTotal \+ $sum_PerrTotal`

		#scale 2 (ex: 500 to 500.00)
		DroppedTtlL3_total=`echo "scale=2; $sum_DroppedTtlL3/1" | bc`
		QueuedL3_total=`echo "scale=2; $sum_QueuedL3/1" | bc`
		DroppedL3_total=`echo "scale=2; $sum_DroppedL3/1" | bc`
		#preq
		preq_initiatedPreq=`echo "scale=2; $sum_initiatedPreq/1" | bc`
		preq_initiatedPreqProactive=`echo "scale=2; $sum_initiatedPreqProactive/1" | bc`
		preq_retransmittedPreq=`echo "scale=2; $sum_retransmittedPreq/1" | bc`
		preq_total=`echo "scale=2; $sum_PreqTotal/1" | bc`
		#prep
		prep_initiatedPrep=`echo "scale=2; $sum_initiatedPrep/1" | bc`
		prep_retransmittedPrep=`echo "scale=2; $sum_retransmittedPrep/1" | bc`
		prep_total=`echo "scale=2; $sum_PrepTotal/1" | bc`
		#perr
		perr_initiatedPerr=`echo "scale=2; $sum_initiatedPerr/1" | bc`
		#perr_retransmittedPerr=`echo "scale=2; $sum_retransmittedPerr/1" | bc`
	        #perr_total=`echo "scale=2; $sum_PerrTotal/1" | bc`

        	#RoutingControlPackets_total=`echo "scale=2; $sum_RoutingControlPackets/1" | bc`

		#ls result_tx*
		#HWMP
		sum_txPreqHWMP=`awk '{ s=s+$1 } END {print s}' result_txPreqHWMP`
		sum_txPrepHWMP=`awk '{ s=s+$1 } END {print s}' result_txPrepHWMP`
		sum_txPerrHWMP=`awk '{ s=s+$1 } END {print s}' result_txPerrHWMP`
		#sum_txMngBytesHWMP=`awk '{ s=s+$1 } END {print s}' result_txMgtBytesHWMP`
		#sum_txDataBytesHWMP=`awk '{ s=s+$1 } END {print s}' result_txDataBytesHWMP`

	        #totalControl
        	sum_RoutingControlPackets=`expr $sum_txPreqHWMP \+ $sum_txPrepHWMP \+ $sum_txPerrHWMP`
        	RoutingControlPackets_total=`echo "scale=2; $sum_RoutingControlPackets/1" | bc`


        	#PMP
		#sum_txOpenPMP=`awk '{ s=s+$1 } END {print s}' result_txOpenPMP`
		#sum_txConfirmPMP=`awk '{ s=s+$1 } END {print s}' result_txConfirmPMP`
		#sum_txClosePMP=`awk '{ s=s+$1 } END {print s}' result_txClosePMP`
		#sum_txMngBytesPMP=`awk '{ s=s+$1 } END {print s}' result_txMgtBytesPMP`
		#sum_droppedPMP=`awk '{ s=s+$1 } END {print s}' result_droppedPMP`

    mkdir -p TxPackets &&
      echo $nb_flows $sum_TxPackets            	    >> TxPackets/TxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p RxPackets &&
      echo $nb_flows $sum_RxPackets            	    >> RxPackets/RxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p AggregateThroughput &&
      echo $nb_flows $sum_AggregateThroughput  	    >> AggregateThroughput/AggregateThroughput-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p LostPackets &&
      echo $nb_flows $sum_LostPackets 		 	        >> LostPackets/LostPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p DeliveryRate &&
      echo $nb_flows $average_DeliveryRate     	    >> DeliveryRate/DeliveryRate-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p DelayMeanAverage &&
      echo $nb_flows $average_DelayMean            	>> DelayMeanAverage/DelayMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p JitterMeanAverage &&
      echo $nb_flows $average_JitterMean           	>> JitterMeanAverage/JitterMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#    mkdir TimesForwarded && echo $nb_flows $sum_TimesForwarded           	>> TimesForwarded/TimesForwarded-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#    mkdir DropMacQueue && echo $nb_flows $sum_DropMacQueue         	    >> DropMacQueue/DropMacQueue-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#    mkdir RxBytes && echo $nb_flows $sum_RxBytes             	    >> RxBytes/RxBytes-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#    mkdir FramesSentTotal && echo $nb_flows $sum_FramesSentTotal           >> FramesSentTotal/FramesSentTotal-nbFlows-$nb_flows-original80211s
#    mkdir FramesSentData && echo $nb_flows $sum_FramesSentData            >> FramesSentData/FramesSentData-nbFlows-$nb_flows-original80211s
#    mkdir FramesSentMng && echo $nb_flows $sum_FramesSentMng             >> FramesSentMng/FramesSentMng-nbFlows-$nb_flows-original80211s
    mkdir -p DroppedTtlL3 &&
      echo $nb_flows $DroppedTtlL3_total		        >> DroppedTtlL3/DroppedTtlL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p QueuedL3 &&
      echo $nb_flows $QueuedL3_total			          >> QueuedL3/QueuedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
    mkdir -p DroppedL3 &&
      echo $nb_flows $DroppedL3_total	  	 	        >> DroppedL3/DroppedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		#preq
		mkdir -p Preq-initiatedPreq &&
      echo $nb_flows $preq_initiatedPreq         	  >> Preq-initiatedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p Preq-initiatedPreqProactive &&
      echo $nb_flows $preq_initiatedPreqProactive  	>> Preq-initiatedPreqProactive/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p Preq-retransmittedPreq &&
      echo $nb_flows $preq_retransmittedPreq	      >> Preq-retransmittedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p Preq-total &&
      echo $nb_flows $preq_total	   	              >> Preq-total/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		#prep
		mkdir -p Prep-initiatedPrep &&
      echo $nb_flows $prep_initiatedPrep         	  >> Prep-initiatedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p Prep-retransmittedPrep &&
      echo $nb_flows $prep_retransmittedPrep	      >> Prep-retransmittedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p Prep-total &&
      echo $nb_flows $prep_total		 	              >> Prep-total/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		#perr
		mkdir -p Perr-initiatedPerr &&
      echo $nb_flows $perr_initiatedPerr         	  >> Perr-initiatedPerr/Perr-initiatedPerr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $perr_retransmittedPerr	      >> Perr-retransmittedPerr/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $perr_total		 	              >> Perr-total/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p txPreqHWMP &&
      echo $nb_flows $sum_txPreqHWMP  	       		  >> txPreqHWMP/txPreqHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p txPrepHWMP &&
      echo $nb_flows $sum_txPrepHWMP  	       		  >> txPrepHWMP/txPrepHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
		mkdir -p txPerrHWMP &&
      echo $nb_flows $sum_txPerrHWMP  	       		  >> txPerrHWMP/txPerrHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
  	mkdir -p RoutingControlPackets &&
      echo $nb_flows $RoutingControlPackets_total 	>> RoutingControlPackets/RoutingControlPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_txDataBytesHWMP  	        >> txMngtxDataHWMP/txDataBytesHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_txOpenPMP  	       		    >> PMP/txOpenPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_txConfirmPMP  	       	  >> PMP/txConfirmPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_txClosePMP  	       		  >> PMP/txClosePMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_txMngBytesPMP  	          >> PMP/txMngBytesPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s
#   echo $nb_flows $sum_droppedPMP  	       		  >> PMP/droppedPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s

		rm -r result*

	      done #r2

      done #r



      #confidence interval 95%
      ./intervaloConfianca.sh ic=95 nrvar=1 TxPackets/TxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s 			 >> plot/pps-$nb_pps/TxPackets-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 RxPackets/RxPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s                     >> plot/pps-$nb_pps/RxPackets-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 AggregateThroughput/AggregateThroughput-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s >> plot/pps-$nb_pps/AggregateThroughput-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 LostPackets/LostPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s                 >> plot/pps-$nb_pps/LostPackets-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 DeliveryRate/DeliveryRate-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s 		 >> plot/pps-$nb_pps/DeliveryRate-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 DelayMeanAverage/DelayMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s       >> plot/pps-$nb_pps/DelayMeanAverage-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 JitterMeanAverage/JitterMeanAverage-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s     >> plot/pps-$nb_pps/JitterMeanAverage-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 TimesForwarded/TimesForwarded-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s           >> plot/pps-$nb_pps/TimesForwarded-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 DroppedTtlL3/DroppedTtlL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s		 >> plot/pps-$nb_pps/DroppedTtlL3-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 QueuedL3/QueuedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s			 >> plot/pps-$nb_pps/QueuedL3-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 DroppedL3/DroppedL3-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s			 >> plot/pps-$nb_pps/DroppedL3-interface-$current_interface-original80211s
      #preq
      ./intervaloConfianca.sh ic=95 nrvar=1 Preq-initiatedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s         	 >> plot/pps-$nb_pps/Preq-initiatedPreq-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 Preq-initiatedPreqProactive/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s 	 >> plot/pps-$nb_pps/Preq-initiatedPreqProactive-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 Preq-retransmittedPreq/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s    		 >> plot/pps-$nb_pps/Preq-retransmittedPreq-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 Preq-total/Preq-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s 		  	 >> plot/pps-$nb_pps/Preq-total-interface-$current_interface-original80211s
      #prep
      ./intervaloConfianca.sh ic=95 nrvar=1 Prep-initiatedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s         	 >> plot/pps-$nb_pps/Prep-initiatedPrep-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 Prep-retransmittedPrep/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s    		 >> plot/pps-$nb_pps/Prep-retransmittedPrep-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 Prep-total/Prep-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s				 >> plot/pps-$nb_pps/Prep-total-interface-$current_interface-original80211s
      #perr
      ./intervaloConfianca.sh ic=95 nrvar=1 Perr-initiatedPerr/Perr-initiatedPerr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s         	 >> plot/pps-$nb_pps/Perr-initiatedPerr-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 Perr-retransmittedPerr/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s    		 >> plot/pps-$nb_pps/Perr-retransmittedPreq-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 Perr-total/Perr-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s				 >> plot/pps-$nb_pps/Perr-total-interface-$current_interface-original80211s

      ./intervaloConfianca.sh ic=95 nrvar=1 RoutingControlPackets/RoutingControlPackets-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 >> plot/pps-$nb_pps/RoutingControlPackets-interface-$current_interface-original80211s

      ./intervaloConfianca.sh ic=95 nrvar=1 txPreqHWMP/txPreqHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 		 >> plot/pps-$nb_pps/txPreqHWMP-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 txPrepHWMP/txPrepHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 		 >> plot/pps-$nb_pps/txPrepHWMP-interface-$current_interface-original80211s
      ./intervaloConfianca.sh ic=95 nrvar=1 txPerrHWMP/txPerrHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 		 >> plot/pps-$nb_pps/txPerrHWMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 txMngtxDataHWMP/txMngBytesHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	 >> plot/pps-$nb_pps/txMngBytesHWMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 txMngtxDataHWMP/txDataBytesHWMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	 >> plot/pps-$nb_pps/txDataBytesHWMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 PMP/txOpenPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	         	 >> plot/pps-$nb_pps/txOpenPMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 PMP/txConfirmPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	         >> plot/pps-$nb_pps/txConfirmPMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 PMP/txClosePMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	        	 >> plot/pps-$nb_pps/txClosePMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 PMP/txMngBytesPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s	 	     	 >> plot/pps-$nb_pps/txMngBytesPMP-interface-$current_interface-original80211s
      #./intervaloConfianca.sh ic=95 nrvar=1 PMP/droppedPMP-interface-$current_interface-flows-$nb_flows-pps-$nb_pps-original80211s				 >> plot/pps-$nb_pps/droppedPMP-interface-$current_interface-original80211s

done #nbFlows
done #interface

cp  $path_results/plot/pps-$nb_pps/*-interface-*-original80211s $path_results/plot/.



###################
##### PLOT ########
###################


cd $path_results/plot

gnuplot TxPackets.plot
gnuplot RxPackets.plot
gnuplot AggregateThroughput.plot
gnuplot LostPackets.plot
gnuplot DeliveryRate.plot
gnuplot DelayMeanAverage.plot
gnuplot JitterMeanAverage.plot
#gnuplot TimesForwarded.pĺot
#gnuplot RxBytes.plot
#gnuplot DropMacQueue.plot
#gnuplot FramesSentTotal.plot
#gnuplot FramesSentData.plot
#gnuplot FramesSentMng.plot
gnuplot DroppedTtlL3.plot
gnuplot QueuedL3.plot
gnuplot DroppedL3.plot

#preq
gnuplot Preq-initiatedPreq.plot
gnuplot Preq-initiatedPreqProactive.plot
gnuplot Preq-retransmittedPreq.plot
gnuplot Preq-total.plot

#prep
gnuplot Prep-initiatedPrep.plot
gnuplot Prep-retransmittedPrep.plot
gnuplot Prep-total.plot

#perr
gnuplot Perr-initiatedPerr.plot

#totalcontrol tx
gnuplot RoutingControlPackets.plot
gnuplot txPreqHWMP.plot
gnuplot txPrepHWMP.plot
gnuplot txPerrHWMP.plot
#gnuplot txMngtxDataHWMP.plot
#gnuplot txMngHWMP.plot
#gnuplot txOpenPMP.plot
#gnuplot txConfirmPMP.plot
#gnuplot txClosePMP.plot
#gnuplot txMngPMP.plot
#gnuplot droppedPMP.plot

epstopdf TxPackets.eps
epstopdf RxPackets.eps
epstopdf AggregateThroughput.eps
epstopdf LostPackets.eps
epstopdf DeliveryRate.eps
epstopdf DelayAverage.eps
epstopdf JitterAverage.eps
#epstopdf TimesForwarded.eps
#epstopdf RxBytes.eps
#epstopdf DropMacQueue.eps
#epstopdf pps-FramesSentTotal.eps
#epstopdf pps-FramesSentData.eps
#epstopdf pps-FramesSentMng.eps
epstopdf DroppedTtlL3.eps
epstopdf QueuedL3.eps
epstopdf DroppedL3.eps
#preq
epstopdf Preq-initiatedPreq.eps
epstopdf Preq-initiatedPreqProactive.eps
epstopdf Preq-retransmittedPreq.eps
epstopdf Preq-total.eps
#prep
epstopdf Prep-initiatedPrep.eps
epstopdf Prep-retransmittedPrep.eps
epstopdf Prep-total.eps
#perr
epstopdf Perr-initiatedPerr.eps
epstopdf RoutingControlPackets.eps
epstopdf txPreqHWMP.eps
epstopdf txPrepHWMP.eps
epstopdf txPerrHWMP.eps
#epstopdf txMngtxDataHWMP.eps
#epstopdf txMngHWMP.eps
#epstopdf txOpenPMP.eps
#epstopdf txConfirmPMP.eps
#epstopdf txClosePMP.eps
#epstopdf txMngPMP.eps
#epstopdf droppedPMP.eps


mkdir -p $path_results/Results-PDF/pps-$nb_pps
mv *.pdf $path_results/Results-PDF/pps-$nb_pps/.

rm -rf *.eps
rm $path_results/plot/*-interface-*-original80211s
